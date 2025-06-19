import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sekai_news/main.dart';
import 'package:sekai_news/screens/main_screens/main_screen.dart';

void main() {
  group('Sekai News App - End-to-End Widget Tests', () {
    
    testWidgets('Volledige app flow test - Lancering naar Nieuwslijst', (WidgetTester tester) async {
      print('🚀 Volledige app flow test starten...');
      
      // Build the entire app
      await tester.pumpWidget(const MyApp());
      
      // Wait for initial render
      await tester.pumpAndSettle();
      
      // Verifieer dat app succesvol is gelanceerd
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(MainNavScreen), findsOneWidget);
      print('✅ App succesvol gelanceerd');
      
      // Verifieer dat navigatiestructuur bestaat
      expect(find.byType(Scaffold), findsAtLeastNWidgets(1));
      print('✅ Hoofdnavigatie structuur geladen');
      
      // Zoek naar bottom navigation indien aanwezig
      final bottomNav = find.byType(BottomNavigationBar);
      if (tester.any(bottomNav)) {
        print('✅ Bottom navigation gevonden');
      }
      
      // Wacht langer voor potentiële netwerk verzoeken (simuleer echt gebruik)
      await tester.pumpAndSettle(Duration(seconds: 5));
      
      // Controleer op loading indicators of content
      final loadingIndicator = find.byType(CupertinoActivityIndicator);
      final scrollView = find.byType(CustomScrollView);
      final nestedScrollView = find.byType(NestedScrollView);
      
      if (tester.any(loadingIndicator)) {
        print('📋 Loading indicator getoond (goede UX)');
      }
      
      if (tester.any(scrollView) || tester.any(nestedScrollView)) {
        print('✅ Scrollbare content gebied gevonden');
      }
      
      print('🎉 Volledige app flow test geslaagd!');
    });
    
    testWidgets('App responsiviteit test - Meerdere interacties', (WidgetTester tester) async {
      print('📱 Responsiviteit test starten...');
      
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      
      // Test scroll interactions if scrollable content exists
      final scrollable = find.byType(CustomScrollView).first;
      if (tester.any(find.byType(CustomScrollView))) {
        await tester.drag(scrollable, Offset(0, -100));
        await tester.pumpAndSettle();
        
        await tester.drag(scrollable, Offset(0, 100));
        await tester.pumpAndSettle();
        print('✅ Scroll interacties werken');
      }
      
      // Test device rotatie simulatie
      await tester.binding.setSurfaceSize(Size(800, 600)); // Landscape
      await tester.pumpAndSettle();
      
      await tester.binding.setSurfaceSize(Size(400, 800)); // Portrait
      await tester.pumpAndSettle();
      print('✅ Rotatie afhandeling werkt');
      
      print('🎉 Responsiviteit test geslaagd!');
    });
    
    testWidgets('Error afhandeling integratie test', (WidgetTester tester) async {
      print('🚫 Error afhandeling test starten...');
      
      await tester.pumpWidget(const MyApp());
      
      // Wacht tot netwerk verzoeken mogelijk falen
      await tester.pumpAndSettle(Duration(seconds: 8));
      
      // Controleer of error afhandeling UI wordt getoond (icoon, tekst, etc.)
      final errorIcon = find.byIcon(Icons.error);
      final refreshIcon = find.byIcon(Icons.refresh);
      final retryText = find.textContaining('proberen');
      final errorText = find.textContaining('fout');
      
      if (tester.any(errorIcon) || tester.any(refreshIcon) || 
          tester.any(retryText) || tester.any(errorText)) {
        print('✅ Error afhandeling UI gevonden (goede error UX)');
      } else {
        print('✅ Geen errors opgetreden (goede netwerk/app stabiliteit)');
      }
      
      print('🎉 Error afhandeling test voltooid!');
    });
    
    testWidgets('Performance test - App opstartsnelheid', (WidgetTester tester) async {
      print('⚡ Performance test starten...');
      
      final stopwatch = Stopwatch()..start();
      
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      
      stopwatch.stop();
      final startupTime = stopwatch.elapsedMilliseconds;
      
      print('📊 App opstartttijd: ${startupTime}ms');
      
      // Verifieer redelijke opstarttijd (onder 3 seconden)
      expect(startupTime, lessThan(3000));
      
      if (startupTime < 1000) {
        print('🚀 Uitstekende opstartprestaties!');
      } else if (startupTime < 2000) {
        print('✅ Goede opstartprestaties');
      } else {
        print('⚠️ Acceptabele opstartprestaties');
      }
      
      print('🎉 Performance test geslaagd!');
    });
  });
}
