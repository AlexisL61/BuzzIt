import 'package:buzzer/components/BuzzerWidget.dart';
import 'package:buzzer/components/ConnectionWidget.dart';
import 'package:buzzer/model/buzzer.dart';
import 'package:buzzer/model/buzzerState.dart';
import 'package:buzzer/model/buzzerTeam.dart';
import 'package:flutter/material.dart';

class BuzzerPage extends StatefulWidget {
  final Buzzer buzzer;

  const BuzzerPage({super.key, required this.buzzer});

  @override
  State<BuzzerPage> createState() => _BuzzerPageState();
}

class _BuzzerPageState extends State<BuzzerPage> {
  bool foregroundActive = false;

  @override
  void initState() {
    widget.buzzer.addListener(() {
      if (widget.buzzer.state != BuzzerState.IDLE) {
        foregroundActive = true;
      } else {
        if (foregroundActive) {
          Future.delayed(Duration(milliseconds: 500), () {
            foregroundActive = false;
            setState(() {});
          });
        }
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Buzzer'),
          actions: [
            IconButton(
                onPressed: () {
                  widget.buzzer.changeTeam();
                },
                icon: Icon(Icons.person))
          ],
        ),
        body: Stack(children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Center(child: BuzzerWidget(buzzer: widget.buzzer))),
                ConnectionWidget(buzzer: widget.buzzer)
              ],
            ),
          ),
          Column(children: [Expanded(child: _buildLockFrame())])
        ]));
  }

  Widget _buildLockFrame() {
    return AnimatedOpacity(
      opacity: widget.buzzer.state != BuzzerState.IDLE ? 1.0 : 0.0,
      duration: Duration(
          milliseconds: widget.buzzer.state != BuzzerState.IDLE ? 200 : 0),
      child: Container(
        width: foregroundActive ? MediaQuery.of(context).size.width : 0,
        color: widget.buzzer.state == BuzzerState.BUZZED ||
                widget.buzzer.state == BuzzerState.LOCKED_BY_TEAM
            ? widget.buzzer.team.color
            : widget.buzzer.ennemyTeam.color,
        child: Column(children: [
          Expanded(
            child: Center(
              child: Text(
                widget.buzzer.state == BuzzerState.BUZZED
                    ? "Vous avez la main"
                    : widget.buzzer.state == BuzzerState.LOCKED_BY_TEAM
                        ? "Votre équipe a la main"
                        : "L'équipe adverse a la main",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          TextButton(
              onLongPress: () {
                widget.buzzer.unbuzz();
              },
              onPressed: () {},
              child: Text("Activer le buzzer"))
        ]),
      ),
    );
  }
}
