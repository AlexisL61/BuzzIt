import 'package:buzzer/pages/ingame/InGamePage.dart';
import 'package:buzzer/pages/menu/MainMenuPage.dart';
import 'package:buzzer/pages/settings/SettingsPage.dart';
import 'package:buzzer/services/api/ApiService.dart';
import 'package:buzzer/services/preferences/SavedPlayerService.dart';
import 'package:buzzer/services/preferences/UserPreferencesService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appInit();
  runApp(const MyApp());
}

Future<void> appInit() async {
  await UserPreferencesService().init();
  await ApiService().init();
  await SavedPlayerService.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        initialRoute: MainMenuPage.route,
        routes: {
          MainMenuPage.route: (context) => const MainMenuPage(),
          InGameRoute.route: (context) => const InGameRoute(),
          SettingsRoute.route: (context) => const SettingsRoute()
        });
  }
}
