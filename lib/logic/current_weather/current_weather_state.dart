part of 'current_weather_bloc.dart';

sealed class CurrentWeatherState extends Equatable {
  const CurrentWeatherState();

  @override
  List<Object> get props => [];
}

final class CurrentWeatherInitialS extends CurrentWeatherState {}

final class CurrentWeatherLoadingS extends CurrentWeatherState {}

final class CurrentWeatherSuccessS extends CurrentWeatherState {
  final Weather weather;

  const CurrentWeatherSuccessS({required this.weather});

  @override
  List<Object> get props => [weather];
}

final class CurrentWeatherByNameSuccessS extends CurrentWeatherState {
  final Weather weather;

  const CurrentWeatherByNameSuccessS({required this.weather});

  @override
  List<Object> get props => [weather];
}

final class CurrentWeatherErrorS extends CurrentWeatherState {
  final String errorString;

  const CurrentWeatherErrorS({required this.errorString});
  @override
  List<Object> get props => [errorString];
}
