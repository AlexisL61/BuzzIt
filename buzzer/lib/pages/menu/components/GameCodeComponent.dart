import 'package:buzzer/components/buttons/BigButton.dart';
import 'package:buzzer/components/cards/BuzzerCard.dart';
import 'package:buzzer/components/cards/RoomCard.dart';
import 'package:buzzer/components/transitions/OpacityTransition.dart';
import 'package:buzzer/model/InGame/ActivePlayer.dart';
import 'package:buzzer/model/InGame/InGamePlayer.dart';
import 'package:buzzer/model/InGame/InGameRoom.dart';
import 'package:buzzer/model/room.dart';
import 'package:buzzer/services/api/httpRequest.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class GameCodeComponent extends StatefulWidget {
  final Function() goingBack;

  const GameCodeComponent({super.key, required this.goingBack});

  @override
  State<GameCodeComponent> createState() => _GameCodeComponentState();
}

class _GameCodeComponentState extends State<GameCodeComponent> {
  Room? roomFound;
  bool roomDataLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: BuzzerCard.buildPurpleCard(
                child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Text("ENTREZ VOTRE CODE",
                      style: GoogleFonts.rubik(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w600))),
                ],
              ),
            ))),
        const SizedBox(height: 16),
        Pinput(
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.characters,
          defaultPinTheme: PinTheme(
            width: 50,
            height: 50,
            textStyle: GoogleFonts.rubik(
                textStyle: TextStyle(
              color: Colors.white,
              fontSize: 30,
            )),
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          length: 4,
          onChanged: (String pin) {
            if (pin.length == 4) {
              retrieveRoomFromCode(pin.toUpperCase());
            } else {
              setState(() {
                roomFound = null;
              });
            }
          },
        ),
        const SizedBox(height: 16),
        _buildRoomFound(),
        const Spacer(),
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: BuzzerCard.buildPurpleCard(
                child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton.filled(
                      onPressed: widget.goingBack,
                      icon: Icon(Icons.arrow_back)),
                  const SizedBox(width: 16),
                  Text("RETOUR AU MENU",
                      style: GoogleFonts.rubik(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w600))),
                ],
              ),
            ))),
      ],
    );
  }

  Future<void> retrieveRoomFromCode(String pin) async {
    print("Retrieving room from code $pin");
    setState(() {
      roomDataLoading = true;
    });
    roomFound = await ApiService.getRoomData(pin);
    setState(() {
      roomDataLoading = false;
    });
  }

  Widget _buildRoomFound() {
    return SizedBox(
      height: 120,
      child: OpacityTransition(
          selectedChild: roomDataLoading
              ? 1
              : roomFound != null
                  ? 2
                  : 0,
          children: [
            SizedBox.shrink(),
            const Padding(
                padding: EdgeInsets.all(16),
                child: BuzzerCard(
                    child: Center(child: CircularProgressIndicator()))),
            roomFound == null
                ? SizedBox.shrink()
                : Padding(
                    padding: EdgeInsets.all(16),
                    child: BigButton(
                      child: RoomCard(room: roomFound!),
                      onPressed: () {
                        Navigator.pushNamed(context, '/ingame',
                            arguments: InGameRoom(roomFound!.id, ActivePlayer("Alexis", ""), InGamePlayer("Alexis2", "")));
                      },
                    ))
          ]),
    );
  }
}
