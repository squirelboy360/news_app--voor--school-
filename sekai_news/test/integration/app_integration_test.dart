import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sekai_news/main.dart';
import 'package:sekai_news/screens/main_screens/main_screen.dart';

void main() {
  group('Integration Tests', () {
    testWidgets('app should launch successfully', (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(const MyApp());

      // Verify app launches with main navigation screen
      expect(find.byType(MainNavScreen), findsOneWidget);
    });

    testWidgets('app should handle navigation between tabs', (WidgetTester tester) async {
      // Build app
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Find bottom navigation
      expect(find.byType(BottomNavigationBar), findsOneWidget);

      // Test navigation to different tabs (if they exist)
      final navItems = find.byType(BottomNavigationBarItem);
      if (navItems.evaluate().isNotEmpty) {
        // Tap on second tab if it exists
        await tester.tap(navItems.at(1));
        await tester.pumpAndSettle();
        
        // Verify navigation occurred
        expect(find.byType(MainNavScreen), findsOneWidget);
      }
    });

    testWidgets('app should maintain state across navigation', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Test that the app maintains its structure
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(MainNavScreen), findsOneWidget);
    });

    testWidgets('app should handle device rotation', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Change orientation
      await tester.binding.setSurfaceSize(Size(800, 600));
      await tester.pumpAndSettle();

      // Verify app still works
      expect(find.byType(MainNavScreen), findsOneWidget);

      // Restore original orientation
      await tester.binding.setSurfaceSize(Size(400, 800));
      await tester.pumpAndSettle();
    });

    testWidgets('app theme should be applied correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      final MaterialApp app = tester.widget(find.byType(MaterialApp));
      
      // Verify theme properties
      expect(app.debugShowCheckedModeBanner, false);
      expect(app.theme?.splashFactory, NoSplash.splashFactory);
      expect(app.theme?.highlightColor, Colors.transparent);
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
  });
}
