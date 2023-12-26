import 'package:buzzer/model/InGame/ActivePlayer.dart';
import 'package:buzzer/model/InGame/BuzzerTeam.dart';
import 'package:flutter/material.dart';

class BuzzerWidget extends StatefulWidget {
  final ActivePlayer buzzer;
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
                  shape: BoxShape.circle, color: widget.buzzer.team.color)),
        ),
        onTap: () {
          widget.buzzer.buzz();
        });
  }
}
