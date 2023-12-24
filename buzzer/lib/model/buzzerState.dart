enum BuzzerState {
  IDLE,
  BUZZED,
  LOCKED;
}

extension BuzzerStateExtension on BuzzerState {
  String get name {
    switch (this) {
      case BuzzerState.IDLE:
        return "IDLE";
      case BuzzerState.BUZZED:
        return "BUZZED";
      case BuzzerState.LOCKED:
        return "LOCKED";
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
      case "LOCKED":
        return BuzzerState.LOCKED;
      default:
        return BuzzerState.IDLE;
    }
  }
}