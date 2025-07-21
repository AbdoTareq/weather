import 'package:geolocator/geolocator.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:weather/core/error/failures.dart';
import 'package:weather/core/features/weather/data/model/weather_mapper.dart';
import 'package:weather/core/features/weather/data/model/weather_model.dart';
import 'package:weather/core/features/weather/domain/entity/weather_wrapper.dart';

import 'package:equatable/equatable.dart';
import 'package:weather/core/features/weather/domain/usecase/get_current_weather_usecase.dart';
part 'weather_state.dart';

class WeatherCubit extends HydratedCubit<WeatherState> {
  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;

  WeatherCubit({required this.getCurrentWeatherUseCase})
    : super(WeatherState(status: RxStatus.initial));

  late Failure _failure;

  Future<void> getCurrentWeather(Position position) async {
    emit(state.copyWith(status: RxStatus.loading));
    final result = await getCurrentWeatherUseCase.call(position);
    result.fold(
      (failure) {
        _failure = failure;
        emit(
          state.copyWith(
            status: state.data != null ? RxStatus.cashed : RxStatus.error,
          ),
        );
      },
      (weather) =>
          emit(state.copyWith(data: weather, status: RxStatus.success)),
    );
  }

  @override
  WeatherState? fromJson(Map<String, dynamic> json) {
    var weather = WeatherModel.fromJson(json);
    var cashedState = state.copyWith(data: weather, status: RxStatus.cashed);
    Future.delayed(Duration(milliseconds: 400)).then((value) {
      if (WeatherModel.fromJson(json).id != null) {
        emit(cashedState);
      } else {
        emit(
          state.copyWith(
            errorMessage: _failure.message,
            status: RxStatus.error,
          ),
        );
      }
    });
    return cashedState;
  }

  @override
  Map<String, dynamic>? toJson(WeatherState state) {
    if (state.status == RxStatus.success || state.status == RxStatus.success) {
      return state.data!.toModel().toJson();
    }
    return null;
  }
}
