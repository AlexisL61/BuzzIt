import 'package:server/model/buzzer.dart';

class Room {
  String id;
  List<Buzzer> buzzers;
  
  Room(this.id): buzzers = [];

  void addBuzzer(Buzzer buzzer) {
    buzzers.add(buzzer);
  }

  void removeBuzzer(Buzzer buzzer) {
    buzzers.remove(buzzer);
  }
}
