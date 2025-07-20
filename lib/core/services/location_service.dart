import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class LocationService {
  Future<LocationPermission> checkLocationPermission();
  Future<Position?> getCurrentLocation();
}

class LocationServiceImp implements LocationService {
  @override
  Future<LocationPermission> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    } else if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
    }
    return permission;
  }

  @override
  Future<Position?> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );
  }
}
