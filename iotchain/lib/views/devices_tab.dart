import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iotchain/controllers/devices_controller.dart';
import 'package:iotchain/model/device_model.dart';
import 'package:iotchain/shared/utils.dart';
import 'package:iotchain/views/device_form.dart';

import 'components/modal_menu.dart';

class DevicesTab extends StatefulWidget {
  DevicesTab({Key key}) : super(key: key);

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

  Future<void> _refreshData() {
    return _fetchDevices().then((value) => setState(() => devices = value));
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
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(Icons.memory, size: 90),
          SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 8),
            Text(device.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            Text(device.ip,
                style: TextStyle(
                    fontSize: 15, color: Theme.of(context).hintColor, fontWeight: FontWeight.w400))
          ]),
          Spacer(),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                device.stateIcon,
                SizedBox(width: 5),
                Text(device.stateView, style: TextStyle(color: Theme.of(context).hintColor))
              ],
            )
          ]),
        ]),
      ),
    ),
    onLongPress: () => _showDeviceMenu(context, device),
  );


  Future<List<Device>> _fetchDevices() async =>
      await DevicesController.getDevices();

  void _showDeviceMenu(BuildContext context, Device device) {
    showModalMenu(context: context, options: [
      ModalMenuOption(
          title: "Transfer device",
          icon: Icons.local_shipping,
          action: () => print("Transfer asset")
      ),
      ModalMenuOption(
          title: "Configure device",
          icon: Icons.phonelink_setup,
          action: () => openPage(context, DeviceForm(model: device))
      ),
      ModalMenuOption(
          title: "Unbind device",
          icon: Icons.link_off,
          action: () => showYesNoDialog(context,
            title: "Unbind ${device.name}",
            message: "This action will reset the device and remove it from the network. Are you sure?",
            onYes: () => DevicesController.unbindDevice(device.id),
            onNo: () => print("close modal"))
      ),
    ]);
  }
}
