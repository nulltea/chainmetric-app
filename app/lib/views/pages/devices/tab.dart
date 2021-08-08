import 'package:chainmetric/main_theme.dart';
import 'package:flutter/material.dart';
import 'package:chainmetric/controllers/bluetooth_adapter.dart';
import 'package:chainmetric/controllers/devices_controller.dart';
import 'package:chainmetric/controllers/gps_adapter.dart';
import 'package:chainmetric/models/device_model.dart';
import 'package:chainmetric/shared/utils.dart';
import 'package:chainmetric/views/components/common/modal_menu.dart';
import 'package:chainmetric/views/components/common/navigation_tab.dart';
import 'package:chainmetric/views/components/common/svg_icon.dart';
import 'package:chainmetric/views/pages/devices/form.dart';
import 'package:chainmetric/views/pages/devices/pairing_page.dart';

class DevicesTab extends NavigationTab {
  DevicesTab({GlobalKey key}) : super(key: key ?? GlobalKey());

  _DevicesTabState get _currentState =>
      (key as GlobalKey)?.currentState as _DevicesTabState;

  @override
  _DevicesTabState createState() => _DevicesTabState();

  @override
  Future refreshData() => _currentState._refreshData();
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
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Devices",
          style: AppTheme.title2.override(fontFamily: "IBM Plex Mono", fontSize: 28)),
      centerTitle: false,
      automaticallyImplyLeading: false,
      elevation: 4,
    ),
    body: RefreshIndicator(
      key: _refreshKey,
      onRefresh: _refreshData,
      child: ListView.builder(
        itemCount: devices.length,
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemBuilder: _listBuilder,
      ),
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
    onLongPress: () => _showDeviceMenu(context, device),
    child: Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Stack(children: [
          const Icon(Icons.memory, size: 90),
          Positioned.fill(
            left: 100,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 8),
              Text(device.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              Text(device.ip,
                  style: TextStyle(
                      fontSize: 15, color: Theme.of(context).hintColor, fontWeight: FontWeight.w400)),
            ]),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(device.stateView, style: TextStyle(color: Theme.of(context).hintColor)),
                const SizedBox(width: 5),
                device.stateIcon,
              ],
            )
          ]),
          Positioned.fill(
            left: 100,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  SvgIcon("sensors", color: Theme.of(context).hintColor),
                  const SizedBox(width: 5),
                  Text("${device.supports.length} metrics supported", style: TextStyle(color: Theme.of(context).hintColor))
                ],
              ),
            ),
          )
        ]),
      ),
    ),
  );

  Future<List<Device>> _fetchDevices() async => DevicesController.getDevices();

  void _showDeviceMenu(BuildContext context, Device device) {
    showModalMenu(context: context, options: [
      ModalMenuOption(
          title: "Configure device",
          icon: Icons.phonelink_setup,
          action: () => openPage(
              context, DeviceForm(model: device),
              then: _refreshData
          )
      ),
      ModalMenuOption(
          title: !Bluetooth.isPaired(device.id)
              ? "Pair device"
              : "Forget device",
          icon: Icons.bluetooth_searching,
          action: () => !Bluetooth.isPaired(device.id)
              ? _startBluetoothPairing(device.id)
              : showYesNoDialog(context,
              title: "Forget ${device.name}",
              message: "This action will unpair the device from your phone. Are you sure?",
              onYes: () => Bluetooth.forgetDevice(device.id)
          )
      ),
      if (Bluetooth.isPaired(device.id)) ModalMenuOption(
            title: "Share location",
            icon: Icons.my_location,
            action: decorateWithLoading(context, () => GeoService.postLocation(device.id))
      ),
      ModalMenuOption(
          title: "Unbind device",
          icon: Icons.link_off,
          action: () => showYesNoDialog(context,
            title: "Unbind ${device.name}",
            message: "This action will reset the device and remove it from the network. Are you sure?",
            onYes: decorateWithLoading(context, () => DevicesController.unbindDevice(device.id)
                .whenComplete(_refreshData)
            )
          )
      ),
    ]);
  }

  void _startBluetoothPairing(String deviceID) {
    showOverlayPage(context: context, builder: (context) => DevicePairing(deviceID));
  }
}
