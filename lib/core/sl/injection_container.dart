import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:requests_inspector/requests_inspector.dart';
import 'package:weather/core/features/location/presentation/cubit/location_cubit.dart';
import 'package:weather/core/features/weather/data/datasource/weather_remote_data_source.dart';
import 'package:weather/core/features/weather/data/repo/weather_repo_imp.dart';
import 'package:weather/core/features/weather/domain/repo/weather_repo.dart';
import 'package:weather/core/features/weather/domain/usecase/get_current_weather_usecase.dart';
import 'package:weather/core/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:weather/core/network/network.dart';
import 'package:weather/core/network/network_info.dart';
import 'package:weather/core/services/location_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  sl.registerLazySingleton(() => LocationCubit(locationService: sl()));
  // Bloc
  sl.registerFactory(() => WeatherCubit(getCurrentWeatherUseCase: sl()));

  // Usecases
  sl.registerLazySingleton(() => GetCurrentWeatherUseCase(weatherRepo: sl()));

  // Repository
  sl.registerLazySingleton<WeatherRepo>(
    () => WeatherRepoImp(networkInfo: sl(), remoteDataSource: sl()),
  );

  // Datasources
  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImp(network: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectionChecker: sl()),
  );
  sl.registerLazySingleton<NetworkInterface>(() => Network(dio: sl()));
  sl.registerLazySingleton<LocationServiceImp>(() => LocationServiceImp());

  //! External
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 1000),
        receiveTimeout: const Duration(seconds: 1000),
        // By default, Dio treats any HTTP status code from 200 to 299 as a successful response. If you need a different range or specific conditions, you can override it using validateStatus.
        validateStatus: (status) {
          // Treat status codes less than 399 as successful
          return status != null;
        },
      ),
    ),
  );
  sl<Dio>().interceptors.addAll([RequestsInspectorInterceptor()]);
}
