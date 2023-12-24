import 'package:buzzer/model/buzzer.dart';
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
      return buildIdleBuzzer();
  }

  Widget buildIdleBuzzer() {
    return InkWell(
        child: SizedBox(
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
          child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary)),
        ),
        onTap: () {
          widget.buzzer.buzz();
        });
  }
}
