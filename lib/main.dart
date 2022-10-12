import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'screens/new_gif_screen.dart';
import 'screens/gif_edition_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chess GIF Editor',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routes: {
        '/': (context) => const NewGifScreen(),
        '/edition': (context) => const GifEditionScreen(),
      },
    );
  }
}
