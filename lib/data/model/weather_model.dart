// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final int id;
  final String condition;
  final String cityName;
  final String description;
  final String icon;
  final double temperature;
  final double feelsLike;
  final double wind;
  final double tempMin;
  final double tempMax;
  final int humidity;
  final int sunrise;
  final int sunset;

  const Weather(
      {required this.id,
      required this.condition,
      required this.cityName,
      required this.description,
      required this.icon,
      required this.temperature,
      required this.feelsLike,
      required this.wind,
      required this.tempMin,
      required this.tempMax,
      required this.humidity,
      required this.sunrise,
      required this.sunset});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'condition': condition,
      'cityName': cityName,
      'description': description,
      'icon': icon,
      'temperature': temperature,
      'feelsLike': feelsLike,
      'wind': wind,
      'tempMin': tempMin,
      'tempMax': tempMax,
      'humidity': humidity,
      'sunrise': sunrise,
      'sunset': sunset,
    };
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      id: map['weather'][0]['id'] as int,
      condition: map['weather'][0]['main'] as String,
      description: map['weather'][0]['description'] as String,
      icon: map['weather'][0]['icon'] as String,
      cityName: map['name'] as String,
      temperature: map['main']['temp'] as double,
      feelsLike: map['main']['feels_like'] as double,
      wind: map['wind']['speed'] as double,
      tempMin: map['main']['temp_min'] as double,
      tempMax: map['main']['temp_max'] as double,
      humidity: map['main']['humidity'] as int,
      sunrise: map['sys']['sunrise'] as int,
      sunset: map['sys']['sunset'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Weather.fromJson(String source) =>
      Weather.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props {
    return [
      id,
      condition,
      cityName,
      description,
      icon,
      temperature,
      feelsLike,
      wind,
      tempMin,
      tempMax,
      humidity,
      sunrise,
      sunset,
    ];
  }
}
