part of 'weather_cubit.dart';

enum RxStatus { loading, success, initial, error, cashed }

class WeatherState extends Equatable {
  final RxStatus status;
  final WeatherEntity? data;
  final String? errorMessage;

  const WeatherState({
    this.status = RxStatus.loading,
    this.data,
    this.errorMessage,
  });

  WeatherState copyWith({
    RxStatus? status,
    WeatherEntity? data,
    String? errorMessage,
  }) {
    return WeatherState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
