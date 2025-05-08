Meteo Senegal
=============

Meteo Senegal est une application Flutter permettant d’afficher la météo actuelle et les prévisions à court terme (sur 24h) pour les villes du Sénégal et d'ailleurs, en utilisant l'API publique OpenWeatherMap.

Fonctionnalités
---------------

- Recherche météo par ville
- Affichage :
  - Température actuelle
  - Conditions météorologiques (nuageux, ensoleillé, etc.)
  - Humidité, vent
  - Icône météo dynamique
- Prévisions sur 24h (3h par 3h)
- Gestion des erreurs (ville introuvable, pas de connexion)
- Interface responsive avec Card, ListView, Icons, etc.
- Code structuré en dossiers : models, services, views

Technologies utilisées
----------------------
- Flutter 3.29.2
- Dart
- Package http
- API REST : OpenWeatherMap

Installation
------------

1. Cloner le dépôt :
   ```bash
   git clone https://github.com/MariemeKmr/AppFlutterMeteo.git
   cd AppFlutterMeteo

2. Installer les dépendances :
   flutter pub get

3. Lancer l’application :
   flutter run

Configuration
-------------

Avant de lancer l’application, insérer votre clé API OpenWeatherMap dans le fichier weather_api.dart :

static const String _apiKey = 'VOTRE_CLE_API';

Vous pouvez obtenir une clé gratuite ici : https://openweathermap.org/appid

Structure du projet
-------------------

lib/
├── models/        # Modèles de données (Weather, Forecast)
├── services/      # Appels API (WeatherApi)
├── views/         # Écrans UI (WeatherScreen, SearchScreen)
├── main.dart      # Point d’entrée de l’app

Auteur
------

Réalisé par Marieme KAMARA dans le cadre d’un TP Flutter à l’ESP UCAD.
