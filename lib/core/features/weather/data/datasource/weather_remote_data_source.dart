import 'package:weather/core/environment/env.dart';
import 'package:weather/core/error/exceptions.dart';
import 'package:weather/core/features/weather/data/model/weather_mapper.dart';
import 'package:weather/core/features/weather/data/model/weather_model.dart';
import 'package:weather/core/features/weather/domain/entity/weather_wrapper.dart';
import 'package:weather/core/network/endpoints.dart';
import 'package:weather/core/network/network.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherEntity> getAll(double lat, double lon);
}

class WeatherRemoteDataSourceImp implements WeatherRemoteDataSource {
  final NetworkInterface network;

  WeatherRemoteDataSourceImp({required this.network});

  @override
  Future<WeatherEntity> getAll(double lat, double lon) async {
    final response = await network.get(
      '${Endpoints.weather}?lat=$lat&lon=$lon&appid=${Env.apiKey}',
    );
    if (response.statusCode == 200) {
      final weatherModel = WeatherModel.fromJson(response.data);
      return weatherModel.toEntity();
    }
    throw ServerException();
  }
}
