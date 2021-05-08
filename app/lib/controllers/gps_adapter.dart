import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:global_configuration/global_configuration.dart';

const String eastCoordinateUUID = "00002ab1-0000-1000-8000-00805f9b34fb";
const String northCoordinateUUID = "00002ab0-0000-1000-8000-00805f9b34fb";
const String locationNameUUID = "00002ab5-0000-1000-8000-00805f9b34fb";

class GeoService {
  static Future postLocation(BluetoothDevice device) async {
    var services = await device.discoverServices();

    var service = services.firstWhere(
            (srv) => srv.uuid == Guid(GlobalConfiguration().getValue("device_bluetooth_service_uuid"))
    );

    var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    var eastCoordinateChar = service.characteristics.firstWhere(
       (char) => char.uuid == Guid(eastCoordinateUUID)
    );
    var northCoordinateChar = service.characteristics.firstWhere(
       (char) => char.uuid == Guid(northCoordinateUUID)
    );
    var locationNameChar = service.characteristics.firstWhere(
       (char) => char.uuid == Guid(locationNameUUID)
    );

    var locationName = "Unknown";
    var placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks.isNotEmpty) {
      locationName = "${placemarks.first.street} ${placemarks.first.name}";
    }

    var latitudePayload = Uint8List(8)..buffer.asByteData().setFloat32(0, position.latitude);
    var longitudePayload = Uint8List(8)..buffer.asByteData().setFloat32(0, position.longitude);
    var locationNamePayload = utf8.encode(locationName);

   if (eastCoordinateChar != null) {
     await eastCoordinateChar.write(latitudePayload.toList());
   }

   if (northCoordinateChar != null) {
     await northCoordinateChar.write(longitudePayload.toList());
   }

   if (locationNameChar != null) {
     await locationNameChar.write(locationNamePayload);
   }
  }
}
