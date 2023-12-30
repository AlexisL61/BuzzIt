import 'package:buzzer/components/buttons/BigButton.dart';
import 'package:buzzer/components/cards/BuzzerCard.dart';
import 'package:buzzer/components/cards/RoomCard.dart';
import 'package:buzzer/components/transitions/OpacityTransition.dart';
import 'package:buzzer/model/InGame/ActivePlayer.dart';
import 'package:buzzer/model/InGame/InGamePlayer.dart';
import 'package:buzzer/model/InGame/InGameRoom.dart';
import 'package:buzzer/model/Player.dart';
import 'package:buzzer/model/Room.dart';
import 'package:buzzer/services/api/ApiService.dart';
import 'package:buzzer/services/connection/RoomConnection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

enum RoomDataStatus { IDLE, LOADING, NOT_FOUND, FOUND }

class GameCodeComponent extends StatefulWidget {
  final Function() goingBack;

  const GameCodeComponent({super.key, required this.goingBack});

  @override
  State<GameCodeComponent> createState() => _GameCodeComponentState();
}

class _GameCodeComponentState extends State<GameCodeComponent> {
  RoomDataStatus roomDataLoading = RoomDataStatus.IDLE;
  Room? roomFound;

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
                roomDataLoading = RoomDataStatus.IDLE;
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
      roomDataLoading = RoomDataStatus.LOADING;
    });
    roomFound = await ApiService().getRoomData(pin);
    setState(() {
      roomDataLoading =
          roomFound == null ? RoomDataStatus.NOT_FOUND : RoomDataStatus.FOUND;
    });
  }

  Widget _buildRoomFound() {
    int selectedChild = 0;
    switch (roomDataLoading) {
      case RoomDataStatus.IDLE:
        selectedChild = 0;
        break;
      case RoomDataStatus.LOADING:
        selectedChild = 1;
        break;
      case RoomDataStatus.FOUND:
        selectedChild = 2;
        break;
      case RoomDataStatus.NOT_FOUND:
        selectedChild = 3;
        break;
    }
    return SizedBox(
      height: 120,
      child: OpacityTransition(selectedChild: selectedChild, children: [
        SizedBox.shrink(),
        const Padding(
            padding: EdgeInsets.all(16),
            child:
                BuzzerCard(child: Center(child: CircularProgressIndicator()))),
        roomFound == null
            ? SizedBox.shrink()
            : Padding(
                padding: EdgeInsets.all(16),
                child: BigButton(
                  child: RoomCard(room: roomFound!),
                  onPressed: () async {
                    InGameRoom inGameRoom = await RoomConnectionService()
                        .connectToRoom(
                            roomFound!,
                            Player("Alexis",
                                "https://avatars.githubusercontent.com/u/30233189?v=4"));
                    Navigator.pushNamed(context, '/ingame',
                        arguments: inGameRoom);
                  },
                )),
        Padding(
            padding: EdgeInsets.all(16),
            child: BuzzerCard(
                child: Center(
                    child: Text("Salle non trouvée",
                        style: GoogleFonts.rubik(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                                fontWeight: FontWeight.w600)))))),
      ]),
    );
  }
}
