// Uitgebreide widget tests voor Sekai News App
// Tests voor UI componenten, navigatie, error handling, en gebruikersinteracties

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sekai_news/main.dart';
import 'package:sekai_news/screens/main_screens/main_screen.dart';
import 'test_helper_nl.dart';

void main() {
  group('Sekai News App Widget Tests', () {
    testWidgets('app moet opstarten en hoofdnavigatie tonen', (WidgetTester tester) async {
      // Bouw onze app en trigger een frame
      await tester.pumpWidgetNL(const MyApp(), 'MyApp wordt geladen');

      // Verifieer dat MainNavScreen wordt weergegeven
      TestHelperNL.verwachtWidgetGevonden(find.byType(MainNavScreen), 'MainNavScreen moet gevonden worden');
      
      // Verifieer dat MaterialApp correct is geconfigureerd
      final MaterialApp app = tester.widget(find.byType(MaterialApp));
      TestHelperNL.verwachtFalse(app.debugShowCheckedModeBanner, 'Debug banner moet uitgeschakeld zijn');
      
      TestHelperNL.printTestSucces('App opstarten test geslaagd');
    });

    testWidgets('app moet juiste theme configuratie hebben', (WidgetTester tester) async {
      await tester.pumpWidgetNL(const MyApp(), 'App met theme wordt geladen');

      final MaterialApp app = tester.widget(find.byType(MaterialApp));
      
      // Verifieer theme eigenschappen
      TestHelperNL.verwachtGelijk(app.theme?.splashFactory, NoSplash.splashFactory, 'Splash factory moet NoSplash zijn');
      TestHelperNL.verwachtGelijk(app.theme?.highlightColor, Colors.transparent, 'Highlight color moet transparant zijn');
      TestHelperNL.verwachtGelijk(app.theme?.splashColor, Colors.transparent, 'Splash color moet transparant zijn');
      
      TestHelperNL.printTestSucces('Theme configuratie test geslaagd');
    });

    testWidgets('app moet tonen zonder fouten', (WidgetTester tester) async {
      // Bouw de app
      await tester.pumpWidgetNL(const MyApp(), 'App wordt gebouwd');
      await tester.pumpAndSettleNL(null, 'UI wordt gestabiliseerd');

      // Verifieer dat er geen exceptions worden gegooid
      TestHelperNL.verwachtNull(tester.takeException(), 'Er mogen geen exceptions zijn');
      
      // Verifieer basis structuur
      TestHelperNL.verwachtWidgetGevonden(find.byType(Scaffold), 'Scaffold moet aanwezig zijn');
      
      TestHelperNL.printTestSucces('Error-vrije rendering test geslaagd');
    });

    testWidgets('app moet navigatie structuur afhandelen', (WidgetTester tester) async {
      await tester.pumpWidgetNL(const MyApp(), 'App met navigatie wordt geladen');
      await tester.pumpAndSettleNL();

      // Verifieer dat bottom navigation bestaat
      TestHelperNL.verwachtWidgetGevonden(find.byType(BottomNavigationBar), 'Bottom navigation moet aanwezig zijn');
      
      TestHelperNL.printTestSucces('Navigatie structuur test geslaagd');
    });

    testWidgets('app moet responsief zijn voor verschillende schermgroottes', (WidgetTester tester) async {
      // Test met telefoon grootte
      TestHelperNL.printTestInfo('Test met telefoon grootte (400x800)');
      await tester.binding.setSurfaceSize(Size(400, 800));
      await tester.pumpWidgetNL(const MyApp(), 'App op telefoon grootte');
      await tester.pumpAndSettleNL();
      
      TestHelperNL.verwachtWidgetGevonden(find.byType(MainNavScreen), 'MainNavScreen moet werken op telefoon grootte');

      // Test met tablet grootte
      TestHelperNL.printTestInfo('Test met tablet grootte (800x1200)');
      await tester.binding.setSurfaceSize(Size(800, 1200));
      await tester.pumpAndSettleNL();
      
      TestHelperNL.verwachtWidgetGevonden(find.byType(MainNavScreen), 'MainNavScreen moet werken op tablet grootte');

      // Reset naar standaard
      await tester.binding.setSurfaceSize(Size(800, 600));
      
      TestHelperNL.printTestSucces('Responsief design test geslaagd');
    });

    testWidgets('app moet widget integriteit behouden', (WidgetTester tester) async {
      await tester.pumpWidgetNL(const MyApp(), 'App integriteit test');
      await tester.pumpAndSettleNL();

      // Test dat widgets renderen zonder overflow
      TestHelperNL.verwachtNull(tester.takeException(), 'Widgets moeten renderen zonder fouten');
      
      // Verifieer kern navigatie structuur
      TestHelperNL.verwachtWidgetGevonden(find.byType(MaterialApp), 'MaterialApp moet aanwezig zijn');
      TestHelperNL.verwachtWidgetGevonden(find.byType(MainNavScreen), 'MainNavScreen moet aanwezig zijn');
      
      TestHelperNL.printTestSucces('Widget integriteit test geslaagd');
    });
  });
}
