part of 'current_weather_bloc.dart';

sealed class CurrentWeatherEvent extends Equatable {
  const CurrentWeatherEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentWeatherE extends CurrentWeatherEvent {}

class GetCurrentWeatherByNameE extends CurrentWeatherEvent {
  final String cityName;

  const GetCurrentWeatherByNameE({required this.cityName});

  @override
  List<Object> get props => [cityName];
}
