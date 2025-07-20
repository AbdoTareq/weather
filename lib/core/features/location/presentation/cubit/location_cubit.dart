import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/core/services/location_service.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit({required this.locationService}) : super(LocationInitial());

  final LocationServiceImp locationService;

  Future<void> getLocation() async {
    emit(LocationLoading());
    await Future.delayed(const Duration(seconds: 1));
    try {
      final permission = await locationService.checkLocationPermission();
      if (permission == LocationPermission.denied) {
        emit(LocationError("Location permission denied"));
        return;
      } else if (permission == LocationPermission.deniedForever) {
        emit(LocationError("Location permission denied forever"));
        return;
      }
      final location = await locationService.getCurrentLocation();
      emit(LocationLoaded(position: location!));
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }
}
