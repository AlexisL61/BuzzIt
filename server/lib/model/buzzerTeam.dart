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