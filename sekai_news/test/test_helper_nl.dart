import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Nederlandse test utilities voor consistente Nederlandse test output
class TestHelperNL {
  
  // Gemeenschappelijke Nederlandse test berichten
  static const String testGeslaagd = 'Test geslaagd';
  static const String testMislukt = 'Test mislukt';
  static const String verwachtResultaat = 'Verwacht resultaat';
  static const String daadwerkelijkResultaat = 'Daadwerkelijk resultaat';
  static const String testWaardeVerwacht = 'Verwachte waarde';
  static const String testWaardeOntvangen = 'Ontvangen waarde';
  
  // API test berichten
  static const String apiTestSuccesvol = 'API call succesvol uitgevoerd';
  static const String apiTestFout = 'API call heeft fout opgeleverd';
  static const String netwerkFout = 'Netwerkfout opgetreden';
  static const String timeoutFout = 'Timeout fout opgetreden';
  static const String jsonParseFout = 'JSON parsing fout';
  
  // UI test berichten
  static const String widgetGevonden = 'Widget gevonden';
  static const String widgetNietGevonden = 'Widget niet gevonden';
  static const String loadingIndicatorZichtbaar = 'Loading indicator zichtbaar';
  static const String errorStateGetoond = 'Error state getoond';
  
  // Veelgebruikte test verwachtingen met Nederlandse berichten
  static void verwachtGelijk<T>(T actual, T expected, [String? reden]) {
    expect(
      actual, 
      equals(expected), 
      reason: reden ?? 'Waarden moeten gelijk zijn: verwacht $expected, kreeg $actual'
    );
  }
  
  static void verwachtNietNull(dynamic value, [String? reden]) {
    expect(
      value, 
      isNotNull, 
      reason: reden ?? 'Waarde mag niet null zijn'
    );
  }
  
  static void verwachtNull(dynamic value, [String? reden]) {
    expect(
      value, 
      isNull, 
      reason: reden ?? 'Waarde moet null zijn'
    );
  }
  
  static void verwachtTrue(bool value, [String? reden]) {
    expect(
      value, 
      isTrue, 
      reason: reden ?? 'Waarde moet true zijn'
    );
  }
  
  static void verwachtFalse(bool value, [String? reden]) {
    expect(
      value, 
      isFalse, 
      reason: reden ?? 'Waarde moet false zijn'
    );
  }
  
  static void verwachtWidgetGevonden(Finder finder, [String? reden]) {
    expect(
      finder, 
      findsOneWidget, 
      reason: reden ?? 'Widget moet gevonden worden'
    );
  }
  
  static void verwachtMeerdereWidgetsGevonden(Finder finder, int aantal, [String? reden]) {
    expect(
      finder, 
      findsNWidgets(aantal), 
      reason: reden ?? 'Moet $aantal widgets vinden'
    );
  }
  
  static void verwachtGeenWidgetGevonden(Finder finder, [String? reden]) {
    expect(
      finder, 
      findsNothing, 
      reason: reden ?? 'Widget mag niet gevonden worden'
    );
  }
  
  /// Print een geformatteerd test bericht in het Nederlands
  static void printTestBericht(String bericht, {String? prefix}) {
    final formattedPrefix = prefix ?? '📋';
    print('$formattedPrefix $bericht');
  }
  
  /// Print test succes bericht
  static void printTestSucces(String bericht) {
    printTestBericht(bericht, prefix: '✅');
  }
  
  /// Print test fout bericht
  static void printTestFout(String bericht) {
    printTestBericht(bericht, prefix: '❌');
  }
  
  /// Print test waarschuwing
  static void printTestWaarschuwing(String bericht) {
    printTestBericht(bericht, prefix: '⚠️');
  }
  
  /// Print test info
  static void printTestInfo(String bericht) {
    printTestBericht(bericht, prefix: 'ℹ️');
  }
}

/// Extension voor Nederlandse test utilities
extension FlutterTestNL on WidgetTester {
  
  /// Pump widget met Nederlandse logging
  Future<void> pumpWidgetNL(Widget widget, [String? beschrijving]) async {
    TestHelperNL.printTestInfo(beschrijving ?? 'Widget wordt geladen...');
    await pumpWidget(widget);
    TestHelperNL.printTestSucces('Widget succesvol geladen');
  }
  
  /// Pump and settle met Nederlandse logging
  Future<void> pumpAndSettleNL([Duration? duration, String? beschrijving]) async {
    TestHelperNL.printTestInfo(beschrijving ?? 'Wachten tot UI stabiliseert...');
    await pumpAndSettle(duration ?? const Duration(seconds: 5));
    TestHelperNL.printTestSucces('UI gestabiliseerd');
  }
}
