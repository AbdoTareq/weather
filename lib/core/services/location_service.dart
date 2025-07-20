import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:logger/logger.dart';

enum MyLocationPermission { allowed, denied, deniedForever }

abstract class LocationServiceInterface {
  Future<MyLocationPermission> checkLocationPermission();
  Future<Position?> getCurrentLocation();
}

class LocationService implements LocationServiceInterface {
  @override
  Future<MyLocationPermission> checkLocationPermission() async {
    bool serviceEnabled = await Permission.location.request().isGranted;
    if (!serviceEnabled) {
      return MyLocationPermission.denied;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return MyLocationPermission.denied;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return MyLocationPermission.deniedForever;
    }
    return MyLocationPermission.allowed;
  }

  @override
  Future<Position?> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
      );
      return position;
    } catch (e) {
      Logger().i("Error getting location: $e");
    }
    return null;
  }
}
