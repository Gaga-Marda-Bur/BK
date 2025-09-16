import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'debug_inspector.dart';
import 'l10n/app_localizations.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    final _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('fr');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Beriya Erfe App',
      locale: _locale,
      // IMPORTANT : delegates de localisation disponibles ici
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // soit AppLocalizations.supportedLocales si tu l'as généré
      supportedLocales: const [
        Locale('fr'), // Français
        Locale('en'), // Anglais
        Locale('ar'), // Arabe
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale == null) return supportedLocales.first;
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode) return supportedLocale;
        }
        return supportedLocales.first;
      },

      // Place DebugInspector autour de HomeScreen ici (dans le MaterialApp)
      home: DebugInspector(
        child: const HomeScreen(),
      ),
    );
  }
}
