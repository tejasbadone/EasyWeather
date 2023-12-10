part of 'weather_forecast_bloc.dart';

sealed class WeatherForecastEvent extends Equatable {
  const WeatherForecastEvent();

  @override
  List<Object> get props => [];
}

final class GetWeatherForecastE extends WeatherForecastEvent {
  final String cityName;

  const GetWeatherForecastE({required this.cityName});

  @override
  List<Object> get props => [cityName];
}
