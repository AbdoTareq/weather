import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/features/location/presentation/cubit/location_cubit.dart';
import 'package:weather/core/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:weather/core/features/weather/presentation/widget/weather_display.dart';
import 'package:weather/core/sl/injection_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<LocationCubit>()..getLocation()),
          BlocProvider(create: (context) => sl<WeatherCubit>()),
        ],
        child: BlocConsumer<LocationCubit, LocationState>(
          listener: (context, locationState) {
            if (locationState is LocationLoaded) {
              context.read<WeatherCubit>().getCurrentWeather(
                locationState.position,
              );
            }
          },
          builder: (context, locationState) {
            if (locationState is LocationError) {
              return Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(locationState.message, textAlign: TextAlign.center),
                    ElevatedButton(
                      onPressed:
                          () => context.read<LocationCubit>().getLocation(),
                      child: Text("Request Permission Location Again"),
                    ),
                  ],
                ),
              );
            } else if (locationState is LocationLoaded) {
              return BlocBuilder<WeatherCubit, WeatherState>(
                builder: (BuildContext context, WeatherState weatherState) {
                  if (weatherState.status == RxStatus.success ||
                      weatherState.status == RxStatus.cashed) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (weatherState.status == RxStatus.cashed)
                          Text(
                            'Cashed data with hydrated bloc',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        WeatherDisplay(weather: weatherState.data!),
                        ElevatedButton(
                          onPressed:
                              () => context
                                  .read<WeatherCubit>()
                                  .getCurrentWeather(locationState.position),
                          child: Text("Refresh Data"),
                        ),
                      ],
                    );
                  } else if (weatherState.status == RxStatus.error) {
                    return Center(child: Text(weatherState.errorMessage!));
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).highlightColor,
                    ),
                  );
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
