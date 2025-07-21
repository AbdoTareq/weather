import 'package:weather/core/features/weather/domain/entity/weather_wrapper.dart';

class WeatherModel extends WeatherEntity {
  WeatherModel({
    super.coord,
    super.weather,
    super.base,
    super.main,
    super.visibility,
    super.wind,
    super.rain,
    super.clouds,
    super.dt,
    super.sys,
    super.timezone,
    super.id,
    super.name,
    super.cod,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
    coord: json['coord'] != null ? CoordModel.fromJson(json['coord']) : null,
    weather:
        json['weather'] != null
            ? List<WeatherInfoModel>.from(
              json['weather'].map((x) => WeatherInfoModel.fromJson(x)),
            )
            : null,
    base: json['base'],
    main: json['main'] != null ? MainModel.fromJson(json['main']) : null,
    visibility: json['visibility'],
    wind: json['wind'] != null ? WindModel.fromJson(json['wind']) : null,
    rain: json['rain'] != null ? RainModel.fromJson(json['rain']) : null,
    clouds:
        json['clouds'] != null ? CloudsModel.fromJson(json['clouds']) : null,
    dt: json['dt'],
    sys: json['sys'] != null ? SysModel.fromJson(json['sys']) : null,
    timezone: json['timezone'],
    id: json['id'],
    name: json['name'],
    cod: json['cod'],
  );

  Map<String, dynamic> toJson() => {
    'coord': (coord as CoordModel?)?.toJson(),
    'weather':
        weather != null
            ? List<dynamic>.from(
              (weather as List<WeatherInfoModel>).map((x) => x.toJson()),
            )
            : null,
    'base': base,
    'main': (main as MainModel?)?.toJson(),
    'visibility': visibility,
    'wind': (wind as WindModel?)?.toJson(),
    'rain': (rain as RainModel?)?.toJson(),
    'clouds': (clouds as CloudsModel?)?.toJson(),
    'dt': dt,
    'sys': (sys as SysModel?)?.toJson(),
    'timezone': timezone,
    'id': id,
    'name': name,
    'cod': cod,
  };
}

class CoordModel extends CoordEntity {
  CoordModel({super.lon, super.lat});

  factory CoordModel.fromJson(Map<String, dynamic> json) =>
      CoordModel(lon: json['lon']?.toDouble(), lat: json['lat']?.toDouble());

  Map<String, dynamic> toJson() => {'lon': lon, 'lat': lat};
}

class WeatherInfoModel extends WeatherInfoEntity {
  WeatherInfoModel({super.id, super.main, super.description, super.icon});

  factory WeatherInfoModel.fromJson(Map<String, dynamic> json) =>
      WeatherInfoModel(
        id: json['id'],
        main: json['main'],
        description: json['description'],
        icon: json['icon'],
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'main': main,
    'description': description,
    'icon': icon,
  };
}

class MainModel extends MainEntity {
  MainModel({
    super.temp,
    super.feelsLike,
    super.tempMin,
    super.tempMax,
    super.pressure,
    super.humidity,
    super.seaLevel,
    super.grndLevel,
  });

  factory MainModel.fromJson(Map<String, dynamic> json) => MainModel(
    temp: json['temp']?.toDouble(),
    feelsLike: json['feels_like']?.toDouble(),
    tempMin: json['temp_min']?.toDouble(),
    tempMax: json['temp_max']?.toDouble(),
    pressure: json['pressure'],
    humidity: json['humidity'],
    seaLevel: json['sea_level'],
    grndLevel: json['grnd_level'],
  );

  Map<String, dynamic> toJson() => {
    'temp': temp,
    'feels_like': feelsLike,
    'temp_min': tempMin,
    'temp_max': tempMax,
    'pressure': pressure,
    'humidity': humidity,
    'sea_level': seaLevel,
    'grnd_level': grndLevel,
  };
}

class WindModel extends WindEntity {
  WindModel({super.speed, super.deg, super.gust});

  factory WindModel.fromJson(Map<String, dynamic> json) => WindModel(
    speed: json['speed']?.toDouble(),
    deg: json['deg'],
    gust: json['gust']?.toDouble(),
  );

  Map<String, dynamic> toJson() => {'speed': speed, 'deg': deg, 'gust': gust};
}

class RainModel extends RainEntity {
  RainModel({super.d1h});

  factory RainModel.fromJson(Map<String, dynamic> json) =>
      RainModel(d1h: json['1h']?.toDouble());

  Map<String, dynamic> toJson() => {'1h': d1h};
}

class CloudsModel extends CloudsEntity {
  CloudsModel({super.all});

  factory CloudsModel.fromJson(Map<String, dynamic> json) =>
      CloudsModel(all: json['all']);

  Map<String, dynamic> toJson() => {'all': all};
}

class SysModel extends SysEntity {
  SysModel({super.type, super.id, super.country, super.sunrise, super.sunset});

  factory SysModel.fromJson(Map<String, dynamic> json) => SysModel(
    type: json['type'],
    id: json['id'],
    country: json['country'],
    sunrise: json['sunrise'],
    sunset: json['sunset'],
  );

  Map<String, dynamic> toJson() => {
    'type': type,
    'id': id,
    'country': country,
    'sunrise': sunrise,
    'sunset': sunset,
  };
}
