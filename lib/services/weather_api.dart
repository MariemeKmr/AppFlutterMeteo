import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';
import '../models/forecast.dart';

/// Service pour consommer l'API OpenWeatherMap
class WeatherApi {
  static const String _apiKey = 'f774a6847fbda92f3bfe723d8f327716'; // Clé API
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  /// Récupère les données météo actuelles pour une ville
  Future<Weather?> fetchWeather(String city) async {
    final url = Uri.parse(
      '$_baseUrl/weather?q=$city&appid=$_apiKey&units=metric&lang=fr',
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Weather.fromJson(json);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Récupère les prévisions météo pour une ville
  Future<List<Forecast>> fetchForecast(String city) async {
    final url = Uri.parse(
      '$_baseUrl/forecast?q=$city&appid=$_apiKey&units=metric&lang=fr',
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List list = data['list'];
        return list.map((json) => Forecast.fromJson(json)).toList();
      } else {
        throw Exception("Erreur lors du chargement des prévisions");
      }
    } catch (e) {
      rethrow;
    }
  }
}
