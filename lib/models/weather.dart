class Weather {
  double? latitude;
  double? longitude;
  String? timezone;
  Current? current;
  List<Minutely>? minutely;
  List<Hourly>? hourly;
  List<Daily>? daily;

  Weather({
    this.latitude,
    this.longitude,
    this.timezone,
    this.current,
    this.minutely,
    this.hourly,
    this.daily,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      latitude: json['lat'],
      longitude: json['lon'],
      timezone: json['timezone'],
      current: json.containsKey('current') ? Current.fromJson(json['current']) : null,
      hourly: json.containsKey('hourly') ? (json['hourly'] as List).map((e) => Hourly.fromJson(e)).toList() : [],
      daily: json.containsKey('daily') ? (json['daily'] as List).map((e) => Daily.fromJson(e)).toList() : [],
    );
  }

  get temp => null;
}

class Current {
  int? dt;
  int? sunrise;
  int? sunset;
  double? temp;
  double? feelsLike;
  int? pressure;
  int? humidity;
  double? dewPoint;
  // double? uvi;
  int? clouds;
  int? visibility;
  double? windSpeed;
  int? windDeg;
  List<WeatherElement>? weather;

  Current({
    this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    // this.uvi,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.weather,
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      dt: json['dt'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      temp: json['temp'],
      feelsLike: json['feels_like'],
      pressure: json['pressure'],
      humidity: json['humidity'],
      dewPoint: json['dew_point'],
      // uvi: json['uvi'],
      clouds: json['clouds'],
      visibility: json['visibility'],
      windSpeed: json['wind_speed'],
      windDeg: json['wind_deg'],
      weather: json.containsKey('weather') ? (json['weather'] as List).map((e) => WeatherElement.fromJson(e)).toList() : [],
    );
  }
}

class Minutely {
  int dt;
  int precipitation;

  Minutely({
    required this.dt,
    required this.precipitation,
  });

  factory Minutely.fromJson(Map<String, dynamic> json) {
    return Minutely(
      dt: json['dt'],
      precipitation: json['precipitation'],
    );
  }
}

class Hourly {
  int? dt;
  double? temp;
  double? feelsLike;
  int? pressure;
  int? humidity;
  double? dewPoint;
  double? uvi;
  int? clouds;
  int? visibility;
  double? windSpeed;
  int? windDeg;
  List<WeatherElement>? weather;
  double? pop;

  Hourly({
    this.dt,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.uvi,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.weather,
    this.pop,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) {
    return Hourly(
      dt: json['dt'],
      temp: json['temp'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      pressure: json['pressure'],
      humidity: json['humidity'],
      dewPoint: json['dew_point'],
      uvi: json['uvi'].toDouble(),
      clouds: json['clouds'],
      visibility: json['visibility'],
      windSpeed: json['wind_speed'],
      windDeg: json['wind_deg'],
      weather: json.containsKey('weather') ? (json['weather'] as List).map((e) => WeatherElement.fromJson(e)).toList() : [],
      pop: json['pop'].toDouble(),
    );
  }
}

class Daily {
  int? dt;
  int? sunrise;
  int? sunset;
  int? moonrise;
  int? moonset;
  double? moonPhase;
  Temp? temp;
  FeelsLike? feelsLike;
  int? pressure;
  int? humidity;
  double? dewPoint;
  double? windSpeed;
  int? windDeg;
  int? windGust;
  List<WeatherElement>? weather;
  int? clouds;
  double? pop;
  double? rain;
  // double? uvi;

  Daily({
    this.dt,
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.moonPhase,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weather,
    this.clouds,
    this.pop,
    this.rain,
    // this.uvi,
  });

  Daily.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    moonrise = json['moonrise'];
    moonset = json['moonset'];
    moonPhase = json['moon_phase'];
    temp = json['temp'] != null ? Temp.fromJson(json['temp']) : null;
    feelsLike = json['feels_like'] != null ? FeelsLike.fromJson(json['feels_like']) : null;
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPoint = json['dew_point'];
    windSpeed = json['wind_speed'];
    windDeg = json['wind_deg'];
    // windGust = json['wind_gust'];
    if (json['weather'] != null) {
      weather = <WeatherElement>[];
      for (var v in (json['weather'] as List)) {
        weather!.add(WeatherElement.fromJson(v));
      }
    }
    clouds = json['clouds'];
    pop = json['pop'].toDouble();
    rain = json['rain'];
    // uvi = json['uvi'];
  }
}

class Temp {
  double? day;
  double? min;
  double? max;
  double? night;
  double? eve;
  double? morn;

  Temp({
    this.day,
    this.min,
    this.max,
    this.night,
    this.eve,
    this.morn,
  });

  Temp.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    min = json['min'];
    max = json['max'];
    night = json['night'];
    eve = json['eve'];
    morn = json['morn'];
  }
}

class FeelsLike {
  double? day;
  double? night;
  double? eve;
  double? morn;

  FeelsLike({
    this.day,
    this.night,
    this.eve,
    this.morn,
  });

  FeelsLike.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    night = json['night'];
    eve = json['eve'];
    morn = json['morn'];
  }
}

class WeatherElement {
  int id;
  String? main;
  String? description;
  String? icon;

  WeatherElement({
    required this.id,
    this.main,
    this.description,
    this.icon,
  });

  factory WeatherElement.fromJson(Map<String, dynamic> json) {
    return WeatherElement(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}
