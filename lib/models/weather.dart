/// Modèle pour les données météo actuelles
class Weather {
  final String description; // Description des conditions météo
  final double temperature; // Température en °C
  final double windSpeed; // Vitesse du vent en m/s
  final int humidity; // Humidité en pourcentage
  final String icon; // Icône météo

  Weather({
    required this.description,
    required this.temperature,
    required this.windSpeed,
    required this.humidity,
    required this.icon,
  });

  /// Convertit les données JSON en objet Weather
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'].toDouble(),
      windSpeed: json['wind']['speed'].toDouble(),
      humidity: json['main']['humidity'],
      icon: json['weather'][0]['icon'],
    );
  }
}
