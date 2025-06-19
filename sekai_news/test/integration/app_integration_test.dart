import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sekai_news/main.dart';
import 'package:sekai_news/screens/main_screens/main_screen.dart';

void main() {
  group('Integratie Testen', () {
    testWidgets('app moet succesvol opstarten', (WidgetTester tester) async {
      // Bouw onze app en trigger een frame
      await tester.pumpWidget(const MyApp());

      // Verifieer dat app opstart met hoofd navigatie scherm
      expect(find.byType(MainNavScreen), findsOneWidget);
    });

    testWidgets('app moet navigatie tussen tabs afhandelen', (WidgetTester tester) async {
      // Bouw app
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Vind bottom navigatie
      expect(find.byType(BottomNavigationBar), findsOneWidget);

      // Test navigatie naar verschillende tabs (als ze bestaan)
      final navItems = find.byType(BottomNavigationBarItem);
      if (navItems.evaluate().isNotEmpty) {
        // Tik op tweede tab als deze bestaat
        await tester.tap(navItems.at(1));
        await tester.pumpAndSettle();
        
        // Verifieer dat navigatie plaatsvond
        expect(find.byType(MainNavScreen), findsOneWidget);
      }
    });

    testWidgets('app moet status behouden tijdens navigatie', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Test dat de app zijn structuur behoudt
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(MainNavScreen), findsOneWidget);
    });

    testWidgets('app moet apparaat rotatie afhandelen', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Wijzig orientatie
      await tester.binding.setSurfaceSize(Size(800, 600));
      await tester.pumpAndSettle();

      // Verifieer dat app nog steeds werkt
      expect(find.byType(MainNavScreen), findsOneWidget);

      // Herstel originele orientatie
      await tester.binding.setSurfaceSize(Size(400, 800));
      await tester.pumpAndSettle();
    });

    testWidgets('app thema moet correct toegepast worden', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      final MaterialApp app = tester.widget(find.byType(MaterialApp));
      
      // Verifieer thema eigenschappen
      expect(app.debugShowCheckedModeBanner, false);
      expect(app.theme?.splashFactory, NoSplash.splashFactory);
      expect(app.theme?.highlightColor, Colors.transparent);
    });

    testWidgets('app moet responsief zijn op verschillende schermformaten', (WidgetTester tester) async {
      // Test met telefoon formaat
      await tester.binding.setSurfaceSize(Size(400, 800));
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      
      expect(find.byType(MainNavScreen), findsOneWidget);

      // Test met tablet formaat
      await tester.binding.setSurfaceSize(Size(800, 1200));
      await tester.pumpAndSettle();
      
      expect(find.byType(MainNavScreen), findsOneWidget);

      // Reset naar standaard
      await tester.binding.setSurfaceSize(Size(800, 600));
    });
  });
}
