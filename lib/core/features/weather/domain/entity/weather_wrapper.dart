class WeatherEntity {
  final CoordEntity? coord;
  final List<WeatherInfoEntity>? weather;
  final String? base;
  final MainEntity? main;
  final int? visibility;
  final WindEntity? wind;
  final RainEntity? rain;
  final CloudsEntity? clouds;
  final int? dt;
  final SysEntity? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;

  WeatherEntity({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.rain,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });
}

class CoordEntity {
  final double? lon;
  final double? lat;

  CoordEntity({this.lon, this.lat});
}

class WeatherInfoEntity {
  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  WeatherInfoEntity({this.id, this.main, this.description, this.icon});
}

class MainEntity {
  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? pressure;
  final int? humidity;
  final int? seaLevel;
  final int? grndLevel;

  MainEntity({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
  });
}

class WindEntity {
  final double? speed;
  final int? deg;
  final double? gust;

  WindEntity({this.speed, this.deg, this.gust});
}

class RainEntity {
  final double? d1h;

  RainEntity({this.d1h});
}

class CloudsEntity {
  final int? all;

  CloudsEntity({this.all});
}

class SysEntity {
  final int? type;
  final int? id;
  final String? country;
  final int? sunrise;
  final int? sunset;

  SysEntity({this.type, this.id, this.country, this.sunrise, this.sunset});
}
