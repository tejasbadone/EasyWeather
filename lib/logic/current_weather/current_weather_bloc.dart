import 'package:bloc/bloc.dart';
import 'package:easyweather_v2/data/model/weather_model.dart';
import 'package:easyweather_v2/data/weather_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  final WeatherRepository weatherRepository = WeatherRepository();
  CurrentWeatherBloc() : super(CurrentWeatherInitialS()) {
    on<GetCurrentWeatherE>(_currentWeatherHandler);
    on<GetCurrentWeatherByNameE>(_currentWeatherByNameHandler);
  }

  void _currentWeatherHandler(event, emit) async {
    emit(CurrentWeatherLoadingS());

    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        permission = await Geolocator.requestPermission();
        // return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }
      Position position = await Geolocator.getCurrentPosition();
      Weather weather = await weatherRepository.getCurrentWeather(
          position.latitude, position.longitude);
      emit(CurrentWeatherSuccessS(weather: weather));
    } catch (e) {
      emit(CurrentWeatherErrorS(errorString: e.toString()));
    }
  }

  void _currentWeatherByNameHandler(event, emit) async {
    emit(CurrentWeatherLoadingS());
    try {
      Weather weather =
          await weatherRepository.getWeatherByName(cityName: event.cityName);

      emit(CurrentWeatherByNameSuccessS(weather: weather));
    } catch (e) {
      emit(CurrentWeatherErrorS(errorString: e.toString()));
    }
  }
}
