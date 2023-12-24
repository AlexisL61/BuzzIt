import 'package:buzzer/model/buzzer.dart';
import 'package:buzzer/pages/BuzzerPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Buzzer buzzer = Buzzer();
    buzzer.init();
    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BuzzerPage(buzzer: buzzer)
    );
  }
}
