import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../services/weather_api.dart';
import 'weather_screen.dart';

/// Écran de recherche pour entrer une ville
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _error;
  bool _isLoading = false;

  /// Lance la recherche pour une ville
  Future<void> _search() async {
    final city = _controller.text.trim();
    if (city.isEmpty) {
      setState(() => _error = "Veuillez entrer une ville.");
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    final api = WeatherApi();
    try {
      final result = await api.fetchWeather(city);
      if (result == null) {
        setState(() {
          _error = "Ville non trouvée.";
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WeatherScreen(weather: result, city: city),
          ),
        );
      }
    } catch (_) {
      setState(() {
        _error = "Erreur de connexion.";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Météo Sénégal'),
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
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Ville (ex: Dakar)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _isLoading ? null : _search,
              child:
                  _isLoading
                      ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                      : const Text('Rechercher'),
            ),
            const SizedBox(height: 20),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            const Spacer(),
            const Text(
              'Powered by AN3M',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
