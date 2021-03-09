import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iotchain/controllers/blockchain_adapter.dart';
import 'package:iotchain/model/device_model.dart';

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

  Widget _deviceCard(Device device) => Card(
    elevation: 5,
    child: Container(
      height: 100,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 5),
              child: Row(
                children: <Widget>[
                  Text(device.name,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Spacer(),
                  Text(device.location),
                  SizedBox(
                    width: 20,
                  )
                ],
              )),
        ),
      ),
    ),
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
    String data = await Blockchain.evaluateTransaction("devices", "List");
    try {
      return data.isNotEmpty ? JsonMapper.deserialize<List<Device>>(data) : <Device>[];
    } on Exception catch (e) {
      print(e.toString());
    }
    return <Device>[];
  }
}
