import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/core/services/location_service.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit({required this.locationService}) : super(LocationInitial());

  final LocationService locationService;

  Future<void> getLocation() async {
    emit(LocationLoading());
    try {
      final permission = await locationService.checkLocationPermission();
      if (permission == MyLocationPermission.denied) {
        emit(LocationError("Location permission denied"));
        return;
      }
      final location = await locationService.getCurrentLocation();
      emit(LocationLoaded(position: location!));
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }
}
