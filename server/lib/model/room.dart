import 'package:server/model/buzzer.dart';
import 'package:server/model/buzzerState.dart';
import 'package:server/model/buzzerTeam.dart';

class Room {
  String id;
  List<Buzzer> buzzers;
  Buzzer? activeBuzzer;

  Room(this.id) : buzzers = [];

  void addBuzzer(Buzzer buzzer) {
    buzzers.add(buzzer);
  }

  void removeBuzzer(Buzzer buzzer) {
    buzzers.remove(buzzer);
  }

  void buzzerActivated(Buzzer buzzer) {
    if (activeBuzzer != null) return;
    activeBuzzer = buzzer;
    buzzers.forEach((element) {
      if (element != buzzer) {
        if (element.team == activeBuzzerTeam)
          element.state = BuzzerState.LOCKED_BY_TEAM;
        else
          element.state = BuzzerState.LOCKED_BY_ENNEMY;
      }
    });
    buzzer.state = BuzzerState.BUZZED;
  }

  BuzzerTeam? get activeBuzzerTeam {
    if (activeBuzzer == null) return null;
    return activeBuzzer!.team;
  }

  void unbuzz() {
    if (activeBuzzer == null) return;
    activeBuzzer!.state = BuzzerState.IDLE;
    activeBuzzer = null;
    buzzers.forEach((element) {
      element.state = BuzzerState.IDLE;
    });
  }
}
