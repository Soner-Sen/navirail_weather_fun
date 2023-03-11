import 'dart:convert';

import 'package:codelab/constants/constants.dart';
import 'package:codelab/models/weather_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<WeatherModel> getWeatherData(String location) async {
    String url = '$baseUrl&q=$location&days=7';

    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        WeatherModel weatherModel = WeatherModel.fromJson(data);
        return weatherModel;
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
