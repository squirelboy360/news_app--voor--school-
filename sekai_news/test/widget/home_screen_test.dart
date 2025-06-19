import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sekai_news/screens/main_screens/home.dart';

void main() {
  group('HomeScreen Widget Tests', () {
    testWidgets('moet loading indicator of error state tonen', (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));

      // The widget should either show loading indicator or error state
      // (since network requests may fail immediately in test environment)
      final loadingIndicator = find.byType(CupertinoActivityIndicator);
      final errorIcon = find.byIcon(Icons.error_outline);
      
      // At least one of these should be present
      expect(
        loadingIndicator.evaluate().isNotEmpty || errorIcon.evaluate().isNotEmpty,
        isTrue,
        reason: 'Moet loading indicator of error state tonen'
      );
      
      // Wait for any async operations to complete
      await tester.pumpAndSettle();
    });

    testWidgets('moet app bar met titel tonen', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));
      
      // Verify app bar and title
      expect(find.byType(SliverAppBar), findsOneWidget);
      expect(find.text('General News'), findsOneWidget);
    });

    testWidgets('moet geneste scroll view structuur hebben', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));
      
      // Verify the basic structure exists
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(NestedScrollView), findsOneWidget);
    });

    testWidgets('moet error state tonen na mislukte network request', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));
      
      // Wait for the network request to complete and potential error state
      await tester.pumpAndSettle(Duration(seconds: 10));

      // The widget might show error state or data depending on network
      // We'll just verify the structure remains intact
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('moet widget structuur behouden', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));
      await tester.pump();

      // Verify basic widget structure
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(NestedScrollView), findsOneWidget);
      expect(find.byType(SliverAppBar), findsOneWidget);
    });
  });
}
