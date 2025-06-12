// Comprehensive widget tests for Sekai News App
// Tests for UI components, navigation, error handling, and user interactions

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sekai_news/main.dart';
import 'package:sekai_news/screens/main_screens/main_screen.dart';

void main() {
  group('Sekai News App Widget Tests', () {
    testWidgets('app should launch and show main navigation', (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(const MyApp());

      // Verify that MainNavScreen is displayed
      expect(find.byType(MainNavScreen), findsOneWidget);
      
      // Verify MaterialApp is configured correctly
      final MaterialApp app = tester.widget(find.byType(MaterialApp));
      expect(app.debugShowCheckedModeBanner, false);
    });

    testWidgets('app should have proper theme configuration', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      final MaterialApp app = tester.widget(find.byType(MaterialApp));
      
      // Verify theme properties
      expect(app.theme?.splashFactory, NoSplash.splashFactory);
      expect(app.theme?.highlightColor, Colors.transparent);
      expect(app.theme?.splashColor, Colors.transparent);
    });

    testWidgets('app should display without errors', (WidgetTester tester) async {
      // Build the app
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Verify no exceptions are thrown
      expect(tester.takeException(), isNull);
      
      // Verify basic structure
      expect(find.byType(Scaffold), findsAtLeastNWidgets(1));
    });

    testWidgets('app should handle navigation structure', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Verify bottom navigation exists
      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets('app should be responsive to different screen sizes', (WidgetTester tester) async {
      // Test with phone size
      await tester.binding.setSurfaceSize(Size(400, 800));
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      
      expect(find.byType(MainNavScreen), findsOneWidget);

      // Test with tablet size
      await tester.binding.setSurfaceSize(Size(800, 1200));
      await tester.pumpAndSettle();
      
      expect(find.byType(MainNavScreen), findsOneWidget);

      // Reset to default
      await tester.binding.setSurfaceSize(Size(800, 600));
    });

    testWidgets('app should maintain widget integrity', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Test that widgets render without overflow
      expect(tester.takeException(), isNull);
      
      // Verify core navigation structure
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(MainNavScreen), findsOneWidget);
    });
  });
}
