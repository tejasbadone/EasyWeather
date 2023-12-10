part of 'weather_forecast_bloc.dart';

sealed class WeatherForecastState extends Equatable {
  const WeatherForecastState();

  @override
  List<Object> get props => [];
}

final class WeatherForecastInitialS extends WeatherForecastState {}

final class WeatherForecastLoadingS extends WeatherForecastState {}

final class WeatherForecastSuccessS extends WeatherForecastState {
  final List<Forecast> todaysForecastList;
  final List<Forecast> fiveDaysForecastList;

  const WeatherForecastSuccessS(
      {required this.todaysForecastList, required this.fiveDaysForecastList});
  @override
  List<Object> get props => [todaysForecastList, fiveDaysForecastList];
}

final class WeatherForecastErrorS extends WeatherForecastState {
  final String errorString;

  const WeatherForecastErrorS({required this.errorString});
  @override
  List<Object> get props => [errorString];
}
