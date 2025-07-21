import 'package:weather/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:weather/core/features/weather/domain/entity/weather_wrapper.dart';

abstract class WeatherRepo {
  Future<Either<Failure, WeatherEntity>> getAll(double lat, double lon);
}
