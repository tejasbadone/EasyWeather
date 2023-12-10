import 'package:bloc/bloc.dart';
import 'package:easyweather_v2/data/model/forecast_model.dart';
import 'package:easyweather_v2/data/weather_repository.dart';
import 'package:equatable/equatable.dart';

part 'weather_forecast_event.dart';
part 'weather_forecast_state.dart';

class WeatherForecastBloc
    extends Bloc<WeatherForecastEvent, WeatherForecastState> {
  final WeatherRepository weatherRepository;
  WeatherForecastBloc(this.weatherRepository)
      : super(WeatherForecastInitialS()) {
    on<GetWeatherForecastE>(_weatherForecastHandler);
  }

  void _weatherForecastHandler(event, emit) async {
    emit(WeatherForecastLoadingS());

    try {
      List<List<Forecast>> items =
          await weatherRepository.getForecast(cityName: event.cityName);

      emit(WeatherForecastSuccessS(
          todaysForecastList: items[0], fiveDaysForecastList: items[1]));
    } catch (e) {
      emit(WeatherForecastErrorS(errorString: e.toString()));
    }
  }
}
