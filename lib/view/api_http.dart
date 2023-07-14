import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class WeatherModel {
  String? cityName;
  double? temp;
  double? wind;
  int? humidity;

  WeatherModel(this.cityName, this.temp, this.wind, this.humidity);

  WeatherModel.fromjson(Map<String, dynamic> json) {
    cityName = json['name'];
    temp = json['main']['temp'];
    wind = json['wind']['speed'];
    humidity = json['main']['humidity'];
  }
}

class Weather {
  Future<WeatherModel>? getWeather(String? location) async {
    var endpoint = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=ab94c47060041d6263793bd5851e80c5&units=metric%27');
    var respone = await http.get(endpoint);
    var body = jsonDecode(respone.body);
    return WeatherModel.fromjson(body);
  }
}
