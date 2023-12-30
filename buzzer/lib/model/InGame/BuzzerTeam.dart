import 'package:flutter/material.dart';

enum BuzzerTeam {
  BLUE,
  RED,
  GREEN,
  YELLOW,
  NONE;
}

extension BuzzerTeamExtension on BuzzerTeam {
  String get name {
    switch (this) {
      case BuzzerTeam.BLUE:
        return "BLUE";
      case BuzzerTeam.RED:
        return "RED";
      case BuzzerTeam.GREEN:
        return "GREEN";
      case BuzzerTeam.YELLOW:
        return "YELLOW";
      case BuzzerTeam.NONE:
        return "NONE";
      default:
        return "UNKNOWN";
    }
  }

  Color get color {
    switch (this) {
      case BuzzerTeam.BLUE:
        return Colors.blue;
      case BuzzerTeam.RED:
        return Colors.red;
      case BuzzerTeam.GREEN:
        return Colors.green;
      case BuzzerTeam.YELLOW:
        return Colors.yellow;
      case BuzzerTeam.NONE:
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  List<Color> get gradient {
    switch (this) {
      case BuzzerTeam.BLUE:
        return [Colors.blue.shade600, Colors.blueAccent.shade700];
      case BuzzerTeam.RED:
        return [Colors.red, Colors.redAccent.shade400];
      case BuzzerTeam.GREEN:
        return [Colors.green.shade400, Colors.greenAccent.shade700];
      case BuzzerTeam.YELLOW:
        return [Colors.yellowAccent.shade700, Colors.yellow.shade800];
      case BuzzerTeam.NONE:
        return [Colors.grey, Colors.grey];
      default:
        return [Colors.grey, Colors.grey];
    }
  }

  static BuzzerTeam fromString(String name) {
    switch (name) {
      case "BLUE":
        return BuzzerTeam.BLUE;
      case "RED":
        return BuzzerTeam.RED;
      case "GREEN":
        return BuzzerTeam.GREEN;
      case "YELLOW":
        return BuzzerTeam.YELLOW;
      case "NONE":
        return BuzzerTeam.NONE;
      default:
        return BuzzerTeam.NONE;
    }
  }
}