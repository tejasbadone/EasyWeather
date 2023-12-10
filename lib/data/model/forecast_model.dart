// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Forecast extends Equatable {
  final int dateTime;
  final num temperature;
  final String icon;
  final String condition;

  const Forecast(
      {required this.dateTime,
      required this.temperature,
      required this.icon,
      required this.condition});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dateTime': dateTime,
      'temperature': temperature,
      'icon': icon,
      'condition': condition,
    };
  }

  factory Forecast.fromMap(Map<String, dynamic> map) {
    return Forecast(
      dateTime: map['dt'] as int,
      temperature: map['main']['temp'] as num,
      icon: map['weather'][0]['icon'] as String,
      condition: map['weather'][0]['main'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Forecast.fromJson(String source) =>
      Forecast.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props => [dateTime, temperature, icon, condition];
}
