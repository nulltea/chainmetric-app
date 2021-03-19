import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iotchain/controllers/blockchain_adapter.dart';
import 'package:iotchain/model/device_model.dart';

import 'components/modal_menu.dart';

class DevicesTab extends StatefulWidget {
  const DevicesTab({Key key}) : super(key: key);

  @override
  _DevicesTabState createState() => _DevicesTabState();
}

class _DevicesTabState extends State<DevicesTab> {
  static const _itemsLength = 50;
  final _refreshKey = GlobalKey<RefreshIndicatorState>();
  List<Device> devices = [];

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() {
    return fetchDevices().then((value) => setState(() => devices = value));
  }

  Widget _listBuilder(BuildContext context, int index) {
    if (index >= _itemsLength) return null;
    return SafeArea(
      top: false,
      bottom: false,
      child: Hero(
        tag: index,
        child: _deviceCard(devices[index]),
      ),
    );
  }

  Widget _deviceCard(Device device) => InkWell(
    child: Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        height: 100,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.memory, size: 85),
              title: Text(device.name),
              subtitle: Text(device.ip),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.circle, color: Colors.green.withAlpha(200)),
                    SizedBox(width: 5),
                    Text("Active", style: TextStyle(color: Theme.of(context).hintColor))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    onLongPress: () => showDeviceMenu(context, device),
  );

  @override
  Widget build(context) => RefreshIndicator(
    key: _refreshKey,
    onRefresh: _refreshData,
    child: ListView.builder(
      itemCount: devices.length,
      padding: EdgeInsets.symmetric(vertical: 12),
      itemBuilder: _listBuilder,
    ),
  );

  Future<List<Device>> fetchDevices() async {
    String data = await Blockchain.evaluateTransaction("devices", "All");
    try {
      return data.isNotEmpty ? JsonMapper.deserialize<List<Device>>(data) : <Device>[];
    } on Exception catch (e) {
      print(e.toString());
    }
    return <Device>[];
  }

  void showDeviceMenu(BuildContext context, Device device) {
    showModalMenu(context: context, options: [
      ModalMenuOption(
          title: "Transfer device",
          icon: Icons.local_shipping,
          action: () => print("Transfer asset")
      ),
      ModalMenuOption(
          title: "Edit asset",
          icon: Icons.edit,
          action: () => print("Edit device")
      ),
      ModalMenuOption(
          title: "Delete asset",
          icon: Icons.delete_forever,
          action: () => print("Delete device")
      ),
    ]);
  }
}
