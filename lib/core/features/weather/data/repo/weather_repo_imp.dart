import 'package:weather/core/error/exceptions.dart';
import 'package:weather/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:weather/core/features/weather/data/datasource/weather_remote_data_source.dart';
import 'package:weather/core/features/weather/domain/entity/weather_wrapper.dart';
import 'package:weather/core/features/weather/domain/repo/weather_repo.dart';
import 'package:weather/core/network/network_info.dart';

class WeatherRepoImp implements WeatherRepo {
  final WeatherRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  WeatherRepoImp({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, WeatherEntity>> getAll(double lat, double lon) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remoteDataSource.getAll(lat, lon);
        return Right(res);
      } on ServerException {
        return Left(ServerFailure(message: 'server failure', data: null));
      }
    } else {
      return const Left(
        OfflineFailure(message: 'please connect to internet', data: null),
      );
    }
  }
}
