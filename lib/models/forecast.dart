/// Modèle pour les prévisions météo
class Forecast {
  final DateTime dateTime; // Date et heure de la prévision
  final double temperature; // Température prévue en °C
  final String description; // Description des conditions météo
  final String icon; // Icône météo

  Forecast({
    required this.dateTime,
    required this.temperature,
    required this.description,
    required this.icon,
  });

  /// Convertit les données JSON en objet Forecast
  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      dateTime: DateTime.parse(json['dt_txt']),
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }
}
