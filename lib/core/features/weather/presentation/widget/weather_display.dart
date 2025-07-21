import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/core/features/weather/domain/entity/weather_wrapper.dart';
import 'package:weather/core/features/weather/presentation/widget/weather_detail_item.dart';

class WeatherDisplay extends StatelessWidget {
  final WeatherEntity weather;
  WeatherDisplay({super.key, required this.weather});

  double? _kelvinToCelsius(double? kelvin) {
    if (kelvin == null) return null;
    return kelvin - 273.15;
  }

  late final tempCelsius = _kelvinToCelsius(weather.main?.temp);
  late final feelsLikeCelsius = _kelvinToCelsius(weather.main?.feelsLike);
  late final temperature = tempCelsius?.toStringAsFixed(1) ?? 'N/A';
  late final feelsLike = feelsLikeCelsius?.toStringAsFixed(1) ?? 'N/A';
  late final humidity = weather.main?.humidity?.toString() ?? 'N/A';
  late final windSpeed = weather.wind?.speed?.toStringAsFixed(1) ?? 'N/A';
  late final mainWeather = weather.weather?.firstOrNull;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            weather.name ?? 'Unknown Location',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            DateFormat.yMMMd().format(
              DateTime.fromMillisecondsSinceEpoch((weather.dt ?? 0) * 1000),
            ),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$temperature°C',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                children: [
                  if (mainWeather?.icon != null)
                    Image.network(
                      'https://openweathermap.org/img/wn/${mainWeather!.icon}@2x.png',
                      width: 60,
                      height: 60,
                      errorBuilder: (context, error, stackTrace) => Container(),
                    ),
                  Text(
                    mainWeather?.description?.toUpperCase() ?? '',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Feels like $feelsLike°C',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  WeatherDetailItem(
                    icon: Icons.water_drop,
                    label: 'Humidity',
                    value: '$humidity%',
                  ),
                  const VerticalDivider(),
                  WeatherDetailItem(
                    icon: Icons.air,
                    label: 'Wind',
                    value: '$windSpeed km/h',
                  ),
                  const VerticalDivider(),
                  WeatherDetailItem(
                    icon: Icons.compress,
                    label: 'Pressure',
                    value: '${weather.main?.pressure ?? 'N/A'} hPa',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
