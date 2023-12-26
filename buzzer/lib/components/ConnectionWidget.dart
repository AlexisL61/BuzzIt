import 'package:buzzer/model/InGame/ActivePlayer.dart';
import 'package:flutter/material.dart';

class ConnectionWidget extends StatefulWidget {
  final ActivePlayer buzzer;

  const ConnectionWidget({super.key, required this.buzzer});

  @override
  State<ConnectionWidget> createState() => _ConnectionWidgetState();
}

class _ConnectionWidgetState extends State<ConnectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(buildText());
  }

  String buildText() {
    if (widget.buzzer.client.isConnected == false) {
      return 'Not connected';
    } else {
      return 'Connected';
    }
  }
}
