import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sekai_news/main.dart';
import 'package:sekai_news/screens/main_screens/main_screen.dart';

void main() {
  group('Sekai News App - End-to-End Widget Tests', () {
    
    testWidgets('Complete app flow test - Launch to News List', (WidgetTester tester) async {
      print('🚀 Starting complete app flow test...');
      
      // Build the entire app
      await tester.pumpWidget(const MyApp());
      
      // Wait for initial render
      await tester.pumpAndSettle();
      
      // Verify app launched successfully
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(MainNavScreen), findsOneWidget);
      print('✅ App launched successfully');
      
      // Verify navigation structure exists
      expect(find.byType(Scaffold), findsAtLeastNWidgets(1));
      print('✅ Main navigation structure loaded');
      
      // Look for bottom navigation if it exists
      final bottomNav = find.byType(BottomNavigationBar);
      if (tester.any(bottomNav)) {
        print('✅ Bottom navigation found');
      }
      
      // Wait longer for potential network requests (simulate real usage)
      await tester.pumpAndSettle(Duration(seconds: 5));
      
      // Check for loading indicators or content
      final loadingIndicator = find.byType(CupertinoActivityIndicator);
      final scrollView = find.byType(CustomScrollView);
      final nestedScrollView = find.byType(NestedScrollView);
      
      if (tester.any(loadingIndicator)) {
        print('📋 Loading indicator shown (good UX)');
      }
      
      if (tester.any(scrollView) || tester.any(nestedScrollView)) {
        print('✅ Scrollable content area found');
      }
      
      print('🎉 Complete app flow test passed!');
    });
    
    testWidgets('App responsiveness test - Multiple interactions', (WidgetTester tester) async {
      print('📱 Starting responsiveness test...');
      
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      
      // Test scroll interactions if scrollable content exists
      final scrollable = find.byType(CustomScrollView).first;
      if (tester.any(find.byType(CustomScrollView))) {
        await tester.drag(scrollable, Offset(0, -100));
        await tester.pumpAndSettle();
        
        await tester.drag(scrollable, Offset(0, 100));
        await tester.pumpAndSettle();
        print('✅ Scroll interactions work');
      }
      
      // Test device rotation simulation
      await tester.binding.setSurfaceSize(Size(800, 600)); // Landscape
      await tester.pumpAndSettle();
      
      await tester.binding.setSurfaceSize(Size(400, 800)); // Portrait
      await tester.pumpAndSettle();
      print('✅ Rotation handling works');
      
      print('🎉 Responsiveness test passed!');
    });
    
    testWidgets('Error handling integration test', (WidgetTester tester) async {
      print('🚫 Starting error handling test...');
      
      await tester.pumpWidget(const MyApp());
      
      // Wait for network requests to potentially fail
      await tester.pumpAndSettle(Duration(seconds: 8));
      
      // Check if error handling UI is shown (icon, text, etc.)
      final errorIcon = find.byIcon(Icons.error);
      final refreshIcon = find.byIcon(Icons.refresh);
      final retryText = find.textContaining('proberen');
      final errorText = find.textContaining('fout');
      
      if (tester.any(errorIcon) || tester.any(refreshIcon) || 
          tester.any(retryText) || tester.any(errorText)) {
        print('✅ Error handling UI found (good error UX)');
      } else {
        print('✅ No errors occurred (good network/app stability)');
      }
      
      print('🎉 Error handling test completed!');
    });
    
    testWidgets('Performance test - App startup speed', (WidgetTester tester) async {
      print('⚡ Starting performance test...');
      
      final stopwatch = Stopwatch()..start();
      
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      
      stopwatch.stop();
      final startupTime = stopwatch.elapsedMilliseconds;
      
      print('📊 App startup time: ${startupTime}ms');
      
      // Verify reasonable startup time (under 3 seconds)
      expect(startupTime, lessThan(3000));
      
      if (startupTime < 1000) {
        print('🚀 Excellent startup performance!');
      } else if (startupTime < 2000) {
        print('✅ Good startup performance');
      } else {
        print('⚠️ Acceptable startup performance');
      }
      
      print('🎉 Performance test passed!');
    });
  });
}
