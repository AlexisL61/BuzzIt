enum BuzzerState {
  IDLE,
  BUZZED,
  LOCKED_BY_TEAM,
  LOCKED_BY_ENNEMY;
}


extension BuzzerStateExtension on BuzzerState {
  String get name {
    switch (this) {
      case BuzzerState.IDLE:
        return "IDLE";
      case BuzzerState.BUZZED:
        return "BUZZED";
      case BuzzerState.LOCKED_BY_TEAM:
        return "LOCKED_BY_TEAM";
      case BuzzerState.LOCKED_BY_ENNEMY:
        return "LOCKED_BY_ENNEMY";
      default:
        return "UNKNOWN";
    }
  }

  static BuzzerState fromString(String name) {
    switch (name) {
      case "IDLE":
        return BuzzerState.IDLE;
      case "BUZZED":
        return BuzzerState.BUZZED;
      case "LOCKED_BY_TEAM":
        return BuzzerState.LOCKED_BY_TEAM;
      case "LOCKED_BY_ENNEMY":
        return BuzzerState.LOCKED_BY_ENNEMY;
      default:
        return BuzzerState.IDLE;
    }
  }
}