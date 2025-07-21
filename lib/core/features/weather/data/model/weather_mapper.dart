import 'package:weather/core/features/weather/data/model/weather_model.dart';
import 'package:weather/core/features/weather/domain/entity/weather_wrapper.dart';

extension WeatherMapper on WeatherModel {
  WeatherEntity toEntity() => WeatherEntity(
    coord: coord != null ? CoordEntity(lon: coord!.lon, lat: coord!.lat) : null,
    weather:
        weather
            ?.map(
              (w) => WeatherInfoEntity(
                id: w.id,
                main: w.main,
                description: w.description,
                icon: w.icon,
              ),
            )
            .toList(),
    base: base,
    main:
        main != null
            ? MainEntity(
              temp: main!.temp,
              feelsLike: main!.feelsLike,
              tempMin: main!.tempMin,
              tempMax: main!.tempMax,
              pressure: main!.pressure,
              humidity: main!.humidity,
              seaLevel: main!.seaLevel,
              grndLevel: main!.grndLevel,
            )
            : null,
    visibility: visibility,
    wind:
        wind != null
            ? WindEntity(speed: wind!.speed, deg: wind!.deg, gust: wind!.gust)
            : null,
    rain: rain != null ? RainEntity(d1h: rain!.d1h) : null,
    clouds: clouds != null ? CloudsEntity(all: clouds!.all) : null,
    dt: dt,
    sys:
        sys != null
            ? SysEntity(
              type: sys!.type,
              id: sys!.id,
              country: sys!.country,
              sunrise: sys!.sunrise,
              sunset: sys!.sunset,
            )
            : null,
    timezone: timezone,
    id: id,
    name: name,
    cod: cod,
  );
}

extension WeatherEntityMapper on WeatherEntity {
  WeatherModel toModel() => WeatherModel(
    coord: coord != null ? CoordModel(lon: coord!.lon, lat: coord!.lat) : null,
    weather:
        weather
            ?.map(
              (w) => WeatherInfoModel(
                id: w.id,
                main: w.main,
                description: w.description,
                icon: w.icon,
              ),
            )
            .toList(),
    base: base,
    main:
        main != null
            ? MainModel(
              temp: main!.temp,
              feelsLike: main!.feelsLike,
              tempMin: main!.tempMin,
              tempMax: main!.tempMax,
              pressure: main!.pressure,
              humidity: main!.humidity,
              seaLevel: main!.seaLevel,
              grndLevel: main!.grndLevel,
            )
            : null,
    visibility: visibility,
    wind:
        wind != null
            ? WindModel(speed: wind!.speed, deg: wind!.deg, gust: wind!.gust)
            : null,
    rain: rain != null ? RainModel(d1h: rain!.d1h) : null,
    clouds: clouds != null ? CloudsModel(all: clouds!.all) : null,
    dt: dt,
    sys:
        sys != null
            ? SysModel(
              type: sys!.type,
              id: sys!.id,
              country: sys!.country,
              sunrise: sys!.sunrise,
              sunset: sys!.sunset,
            )
            : null,
    timezone: timezone,
    id: id,
    name: name,
    cod: cod,
  );
}
