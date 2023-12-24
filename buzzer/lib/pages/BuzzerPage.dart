import 'package:buzzer/components/BuzzerWidget.dart';
import 'package:buzzer/components/ConnectionWidget.dart';
import 'package:buzzer/model/buzzer.dart';
import 'package:flutter/material.dart';

class BuzzerPage extends StatefulWidget {
  final Buzzer buzzer;

  const BuzzerPage({super.key, required this.buzzer});

  @override
  State<BuzzerPage> createState() => _BuzzerPageState();
}

class _BuzzerPageState extends State<BuzzerPage> {
  @override
  void initState() {
    widget.buzzer.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buzzer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Center(child:BuzzerWidget(buzzer: widget.buzzer))),
            ConnectionWidget(buzzer: widget.buzzer)
          ],
        ),
      ),
    );
  }
}
