import 'package:buzzer/model/InGame/ActivePlayer.dart';
import 'package:buzzer/pages/ingame/BuzzerPage.dart';
import 'package:buzzer/pages/ingame/InGamePage.dart';
import 'package:buzzer/pages/menu/MainMenuPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
        initialRoute: MainMenuPage.route,
        routes: {
          MainMenuPage.route: (context) => MainMenuPage(),
          InGamePage.route:(context) => InGamePage()
        });
  }
}
