import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/core/error/failures.dart';
import 'package:weather/core/features/weather/domain/entity/weather_wrapper.dart';
import 'package:weather/core/features/weather/domain/repo/weather_repo.dart';
import 'package:weather/core/usecases/usecase.dart';

class GetCurrentWeatherUseCase implements UseCase<WeatherEntity, Position> {
  final WeatherRepo weatherRepo;

  GetCurrentWeatherUseCase({required this.weatherRepo});

  @override
  Future<Either<Failure, WeatherEntity>> call(Position params) async {
    return await weatherRepo.getAll(params.latitude, params.longitude);
  }
}
