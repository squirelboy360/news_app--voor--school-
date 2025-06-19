import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sekai_news/screens/main_screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('nl', 'NL'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('nl', 'NL'),
        Locale('en', 'US'),
      ],
      color: Colors.white54,
      theme: ThemeData(
        splashColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            elevation: 0,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.shifting,
            unselectedItemColor: Colors.grey,
            landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
            showSelectedLabels: false,
            selectedIconTheme: IconThemeData(size: 50)),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: const MainNavScreen(),
    );
  }
}
