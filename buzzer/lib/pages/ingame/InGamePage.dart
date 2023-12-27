import 'package:buzzer/components/buttons/BigButton.dart';
import 'package:buzzer/model/InGame/InGameRoom.dart';
import 'package:flutter/material.dart';

class InGamePage extends StatefulWidget {
  static const String route = "/ingame";

  const InGamePage({super.key});

  @override
  State<InGamePage> createState() => _InGamePageState();
}

class _InGamePageState extends State<InGamePage> {
  bool foregroundActive = false;
  InGameRoom? inGameRoom;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    inGameRoom = ModalRoute.of(context)!.settings.arguments as InGameRoom;
    return Scaffold(body: Stack(children: [_buildRoomCode()]));
  }

  Widget _buildRoomCode() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            width: 200,
            child: BigButton(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                child: Container(
                  color: Colors.deepPurpleAccent,
                  child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        inGameRoom!.id,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2),
                        textAlign: TextAlign.center,
                      )),
                ),
                onPressed: () {}),
          ),
        )
      ],
    );
  }
}
