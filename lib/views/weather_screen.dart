import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/weather.dart';
import '../models/forecast.dart';
import '../services/weather_api.dart';
import '../providers/theme_provider.dart';

/// Écran pour afficher les informations météo et les prévisions
class WeatherScreen extends StatefulWidget {
  final Weather weather;
  final String city;

  const WeatherScreen({super.key, required this.weather, required this.city});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<List<Forecast>> _forecastFuture;

  @override
  void initState() {
    super.initState();
    _forecastFuture = WeatherApi().fetchForecast(widget.city);
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Météo à ${widget.city}"),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.themeMode == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: themeProvider.toggleTheme,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Informations météo actuelles
            Card(
              color:
                  Theme.of(context).brightness == Brightness.light
                      ? const Color(
                        0xFFE6E6FA,
                      ) // Lavande pastel pour le mode clair
                      : Theme.of(
                        context,
                      ).cardColor, // Couleur par défaut pour le mode sombre
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Icône météo correspondant à la condition actuelle
                        Image.network(
                          "https://openweathermap.org/img/wn/${widget.weather.icon}@4x.png",
                          width: 80,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.weather.temperature} °C",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                            Text(
                              widget.weather.description.toUpperCase(),
                              style: TextStyle(
                                fontSize: 18,
                                color: textColor?.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Icon(Icons.air, size: 30),
                            const SizedBox(height: 4),
                            Text(
                              "Vent : ${widget.weather.windSpeed} m/s",
                              style: TextStyle(color: textColor),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(Icons.water_drop, size: 30),
                            const SizedBox(height: 4),
                            Text(
                              "Humidité : ${widget.weather.humidity}%",
                              style: TextStyle(color: textColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Titre pour les prévisions
            Text(
              "Prévisions",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            const SizedBox(height: 10),
            // Prévisions météo
            Expanded(
              child: FutureBuilder<List<Forecast>>(
                future: _forecastFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Erreur de chargement",
                        style: TextStyle(color: textColor),
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        "Aucune prévision disponible",
                        style: TextStyle(color: textColor),
                      ),
                    );
                  }

                  final forecasts = snapshot.data!;
                  final groupedForecasts = groupForecastsByDay(forecasts);

                  return ListView(
                    children: [
                      // Prévisions à court terme
                      const Text(
                        "Prévisions à court terme (3 à 5 heures)",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 120,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5, // Limité aux 5 prochaines prévisions
                          separatorBuilder:
                              (_, __) => const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            final forecast = forecasts[index];
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("${forecast.dateTime.hour}h"),
                                    Image.network(
                                      "https://openweathermap.org/img/wn/${forecast.icon}@2x.png",
                                      width: 50,
                                    ),
                                    Text("${forecast.temperature}°C"),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Prévisions à long terme
                      const Text(
                        "Prévisions à long terme (jusqu'à 5 jours)",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...groupedForecasts.keys.map((date) {
                        final dailyForecasts = groupedForecasts[date]!;
                        return Card(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color(
                                    0xFFE6E6FA,
                                  ) // Lavande pastel pour le mode clair
                                  : Theme.of(
                                    context,
                                  ).cardColor, // Couleur par défaut pour le mode sombre
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  date,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 100,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: dailyForecasts.length,
                                    separatorBuilder:
                                        (_, __) => const SizedBox(width: 12),
                                    itemBuilder: (context, index) {
                                      final forecast = dailyForecasts[index];
                                      return Column(
                                        children: [
                                          Text("${forecast.dateTime.hour}h"),
                                          Image.network(
                                            "https://openweathermap.org/img/wn/${forecast.icon}@2x.png",
                                            width: 50,
                                          ),
                                          Text("${forecast.temperature}°C"),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            // Footer
            const Text(
              'Powered by AN3M',
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Regroupe les prévisions par jour
Map<String, List<Forecast>> groupForecastsByDay(List<Forecast> forecasts) {
  final Map<String, List<Forecast>> grouped = {};
  for (var forecast in forecasts) {
    final date =
        forecast.dateTime.toLocal().toString().split(' ')[0]; // YYYY-MM-DD
    if (!grouped.containsKey(date)) {
      grouped[date] = [];
    }
    grouped[date]!.add(forecast);
  }
  return grouped;
}
