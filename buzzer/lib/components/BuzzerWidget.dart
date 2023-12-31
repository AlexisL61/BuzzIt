import 'package:audioplayers/audioplayers.dart';
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
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return buildIdleBuzzer();
  }

  Widget buildIdleBuzzer() {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
        child: SizedBox(
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
          child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: widget.buzzer.team.gradient),
                  boxShadow: !isHovering ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 0)
                ),
              ]:null)),
        ),
        onTapDown: (TapDownDetails details) {
          setState(() {
            isHovering = true;
          });
        },
        onTapUp: (TapUpDetails details) {
          setState(() {
            isHovering = false;
          });
        },
        onTap: () {
          widget.buzzer.buzz();
          
          final player = AudioPlayer();
          player.play(AssetSource('sounds/buzz.mp3'));
        });
  }
}
