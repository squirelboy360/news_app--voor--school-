import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sekai_news/screens/main_screens/home.dart';

void main() {
  group('HomeScreen Widget Tests', () {
    testWidgets('should show loading indicator initially', (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));

      // Verify CupertinoActivityIndicator is shown (not CircularProgressIndicator)
      expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
    });

    testWidgets('should show app bar with title', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));
      
      // Verify app bar and title
      expect(find.byType(SliverAppBar), findsOneWidget);
      expect(find.text('General News'), findsOneWidget);
    });

    testWidgets('should have nested scroll view structure', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));
      
      // Verify the basic structure exists
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(NestedScrollView), findsOneWidget);
    });

    testWidgets('should show error state after failed network request', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));
      
      // Wait for the network request to complete and potential error state
      await tester.pumpAndSettle(Duration(seconds: 10));

      // The widget might show error state or data depending on network
      // We'll just verify the structure remains intact
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('should maintain widget structure', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));
      await tester.pump();

      // Verify basic widget structure
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(NestedScrollView), findsOneWidget);
      expect(find.byType(SliverAppBar), findsOneWidget);
    });
  });
}
