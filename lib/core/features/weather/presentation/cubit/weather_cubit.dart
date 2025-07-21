import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/core/features/weather/domain/entity/weather_wrapper.dart';

import 'package:equatable/equatable.dart';
import 'package:weather/core/features/weather/domain/usecase/get_current_weather_usecase.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;

  WeatherCubit({required this.getCurrentWeatherUseCase})
    : super(WeatherInitial());

  Future<void> getCurrentWeather(Position position) async {
    emit(WeatherLoading());
    final result = await getCurrentWeatherUseCase.call(position);
    result.fold(
      (failure) => emit(WeatherError(failure.message)),
      (weather) => emit(WeatherLoaded(weather: weather)),
    );
  }
}
