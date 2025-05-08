import 'package:flutter/material.dart';

/// Fournit un mode de thème dynamique (clair/sombre)
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode =
      ThemeMode.system; // Mode par défaut basé sur le système

  ThemeMode get themeMode => _themeMode;

  /// Bascule entre le mode clair et sombre
  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Notifie les widgets dépendants
  }
}
