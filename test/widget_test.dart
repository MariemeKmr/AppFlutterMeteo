import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meteo_senegal/main.dart';

void main() {
  testWidgets('Recherche de ville visible sur l\'écran d\'accueil', (
    WidgetTester tester,
  ) async {
    // Lancer l'app
    await tester.pumpWidget(const MeteoSenegalApp());

    // Vérifie la présence du champ de texte
    expect(find.byType(TextField), findsOneWidget);

    // Vérifie la présence du bouton Rechercher
    expect(find.text('Rechercher'), findsOneWidget);
  });
}
