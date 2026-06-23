# Météo Sénégal

Application mobile Flutter d'affichage de la météo en temps réel, avec recherche par ville, prévisions sur 5 jours et mode sombre/clair dynamique.

---

## Fonctionnalités

- Recherche météo par nom de ville (monde entier, optimisée pour le Sénégal)
- Affichage des conditions actuelles :
  - Température en °C
  - Description des conditions (nuageux, ensoleillé, pluie...)
  - Vitesse du vent (m/s) et humidité (%)
  - Icône météo dynamique depuis OpenWeatherMap
- Prévisions à court terme : les 5 prochaines tranches de 3h
- Prévisions à long terme : jusqu'à 5 jours, groupées par date
- Mode sombre / mode clair avec basculement en un clic (Provider)
- Gestion des erreurs : ville introuvable, perte de connexion

---

## Stack technique

| Composant | Technologie |
|---|---|
| Framework | Flutter 3 / Dart |
| Gestion d'état | Provider 6 |
| Requêtes HTTP | package `http` |
| API météo | OpenWeatherMap (données en français) |
| Cible | Android, iOS, Web, Desktop |

---

## Architecture du projet

```
lib/
├── main.dart                    # Point d'entrée, injection du ThemeProvider
├── models/
│   ├── weather.dart             # Modèle météo actuelle (temp, vent, humidité, icône)
│   └── forecast.dart            # Modèle prévision (dateTime, temp, description, icône)
├── services/
│   └── weather_api.dart         # Appels OpenWeatherMap (/weather et /forecast)
├── providers/
│   └── theme_provider.dart      # Gestion du thème clair/sombre (ChangeNotifier)
└── views/
    ├── search_screen.dart       # Écran d'accueil avec champ de recherche
    └── weather_screen.dart      # Écran météo : données actuelles + prévisions
```

---

## Installation

### Prérequis
- Flutter SDK >= 3.7
- Un compte [OpenWeatherMap](https://openweathermap.org/appid) (clé API gratuite)

### Étapes

```bash
# 1. Cloner le dépôt
git clone https://github.com/MariemeKmr/AppFlutterMeteo.git
cd AppFlutterMeteo

# 2. Installer les dépendances
flutter pub get

# 3. Ajouter votre clé API dans lib/services/weather_api.dart
# Remplacer la valeur de _apiKey par votre propre clé

# 4. Lancer l'application
flutter run
```

### Configuration de la clé API

Dans `lib/services/weather_api.dart` :

```dart
static const String _apiKey = 'VOTRE_CLE_API_ICI';
```

Clé gratuite disponible sur : https://openweathermap.org/appid

---

## Aperçu des écrans

| Écran | Description |
|---|---|
| `SearchScreen` | Champ de saisie ville + bouton rechercher + indicateur de chargement |
| `WeatherScreen` | Carte météo actuelle + liste prévisions court terme (horizontal) + prévisions long terme groupées par jour |

---

## Dépendances

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.4.0        # Requêtes HTTP vers l'API
  provider: ^6.1.5    # Gestion d'état (thème)
  geolocator: ^14.0.0 # Géolocalisation (prévu)
  lottie: ^3.3.1      # Animations météo (prévu)
```

---

## Auteur

**Marieme KAMARA** - Étudiante en Génie Logiciel et Systèmes d'Information réalisé dans le cadre d’un TP Flutter à l’ESP UCAD.
École Supérieure Polytechnique de Dakar (ESP / UCAD)  
GitHub : [@MariemeKmr](https://github.com/MariemeKmr)

---

*Données météo fournies par [OpenWeatherMap](https://openweathermap.org)*

