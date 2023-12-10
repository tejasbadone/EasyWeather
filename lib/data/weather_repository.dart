import 'dart:convert';
import 'package:easyweather_v2/data/model/forecast_model.dart';
import 'package:easyweather_v2/data/weather_api.dart';
import 'package:easyweather_v2/data/model/weather_model.dart';
import 'package:easyweather_v2/utils/functions.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WeatherRepository {
  final WeatherApi weatherApi = WeatherApi();

  Future<Weather> getCurrentWeather(
    double lat,
    double lon,
  ) async {
    try {
      http.Response res = await weatherApi.getCurrentWeather(lat, lon);

      if (res.statusCode == 200) {
        Weather weather = Weather.fromJson(
          jsonEncode(
            jsonDecode(res.body),
          ),
        );

        return weather;
      } else {
        throw jsonDecode(res.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Weather> getWeatherByName({required String cityName}) async {
    try {
      http.Response res = await weatherApi.getWeatherByName(cityName);

      if (res.statusCode == 200) {
        Weather weather = Weather.fromJson(
          jsonEncode(
            jsonDecode(res.body),
          ),
        );
        return weather;
      } else {
        throw jsonDecode(res.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<List<Forecast>>> getForecast({required String cityName}) async {
    try {
      final dateTimeNow = DateTime.now();
      List<Forecast> forecastList = [];
      List<Forecast> todaysForecastList = [];
      List<Forecast> fiveDaysForecastList = [];

      http.Response res = await weatherApi.getForecast(cityName);

      final formattedDate =
          DateFormat('MM-dd-yyyy').format(dateTimeNow.toLocal()).toString();

      if (res.statusCode == 200) {
        for (int i = 0; i < jsonDecode(res.body)['list'].length; i++) {
          final forecastDate =
              formatDate(jsonDecode(res.body)['list'][i]['dt']);
          if (forecastDate == formattedDate) {
            todaysForecastList.add(
              Forecast.fromJson(
                jsonEncode(
                  jsonDecode(res.body)['list'][i],
                ),
              ),
            );
          } else {
            forecastList.add(
              Forecast.fromJson(
                jsonEncode(
                  jsonDecode(res.body)['list'][i],
                ),
              ),
            );
          }
        }
      }

      for (int i = 0; i < forecastList.length; i++) {
        final forecastDate = formatTimeHr(forecastList[i].dateTime);
        if ('11' == forecastDate) {
          fiveDaysForecastList.add(forecastList[i]);
        }
      }

      return [todaysForecastList, fiveDaysForecastList];
    } catch (e) {
      rethrow;
    }
  }
}
