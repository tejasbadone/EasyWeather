import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  final apiKey = dotenv.env['API_KEY'];
  final client = http.Client();

  Future<http.Response> getCurrentWeather(
    var lat,
    var lon,
  ) async {
    try {
      http.Response res = await client.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric'));

      return res;
    } catch (e) {
      if (e is SocketException) {
        throw 'Please make sure your location service, internet connectivity is enabled!';
      } else {
        rethrow;
      }
    }
  }

  Future<http.Response> getWeatherByName(String cityName) async {
    try {
      http.Response res = await client.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric'));

      return res;
    } catch (e) {
      if (e is SocketException) {
        throw 'Please make sure your location service, internet connectivity is enabled!';
      } else {
        rethrow;
      }
    }
  }

  Future<http.Response> getForecast(String cityName) async {
    try {
      http.Response res = await client.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$apiKey&units=metric'));

      return res;
    } catch (e) {
      if (e is SocketException) {
        throw 'Please make sure your location service, internet connectivity is enabled!';
      } else {
        rethrow;
      }
    }
  }
}
