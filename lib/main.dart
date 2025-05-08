import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'views/search_screen.dart';

void main() {
  runApp(
    // Fournit le ThemeProvider à l'ensemble de l'application
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MeteoSenegalApp(),
    ),
  );
}

class MeteoSenegalApp extends StatelessWidget {
  const MeteoSenegalApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Récupère le thème actuel via ThemeProvider
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Météo Sénégal',
      theme: ThemeData.light(), // Thème clair
      darkTheme: ThemeData.dark(), // Thème sombre
      themeMode: themeProvider.themeMode, // Mode de thème dynamique
      home: const SearchScreen(), // Écran de recherche comme écran d'accueil
      debugShowCheckedModeBanner: false, // Supprime le bandeau de débogage
    );
  }
}
