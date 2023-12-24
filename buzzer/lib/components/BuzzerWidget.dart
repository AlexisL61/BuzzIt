import 'package:buzzer/model/buzzer.dart';
import 'package:buzzer/model/buzzerState.dart';
import 'package:flutter/material.dart';

class BuzzerWidget extends StatefulWidget {
  final Buzzer buzzer;
  const BuzzerWidget({super.key, required this.buzzer});

  @override
  State<BuzzerWidget> createState() => _BuzzerWidgetState();
}

class _BuzzerWidgetState extends State<BuzzerWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.buzzer.state == BuzzerState.IDLE) {
      return buildIdleBuzzer();
    } else {
      return buildBuzzerPressed();
    }
  }

  Widget buildIdleBuzzer(){
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      )
    );
  }

  Widget buildBuzzerPressed(){
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
      )
    );
  }
}