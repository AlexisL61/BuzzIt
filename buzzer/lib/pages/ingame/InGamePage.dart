import 'package:buzzer/components/BuzzerWidget.dart';
import 'package:buzzer/components/buttons/BigButton.dart';
import 'package:buzzer/components/cards/InGamePlayerCard.dart';
import 'package:buzzer/components/dialogs/ReconnectDialog.dart';
import 'package:buzzer/config.dart';
import 'package:buzzer/model/InGame/BuzzerTeam.dart';
import 'package:buzzer/model/InGame/InGameRoom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class InGameRoute extends StatelessWidget {
  static const String route = "/ingame";
  const InGameRoute({super.key});

  @override
  Widget build(BuildContext context) {
    InGameRoom inGameRoom =
        ModalRoute.of(context)!.settings.arguments as InGameRoom;
    return InGamePage(inGameRoom: inGameRoom);
  }
}

class InGamePage extends StatefulWidget {
  final InGameRoom inGameRoom;

  const InGamePage({super.key, required this.inGameRoom});

  @override
  State<InGamePage> createState() => _InGamePageState();
}

class _InGamePageState extends State<InGamePage> {
  bool foregroundActive = false;

  @override
  void initState() {
    super.initState();

    widget.inGameRoom.currentPlayer.addListener(() {
      if (mounted == false)
        return;
      if (widget.inGameRoom.currentPlayer.client.isConnected == false) {
        showReconnectDialog();
      }
      setState(() {});
    });

    widget.inGameRoom.addActivePlayerUpdateListener((player) {
      if (mounted == false)
        return; 
      setState(() {
        foregroundActive = player != null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      _buildBackground(),
      _buildInGamePlayerCard(),
      _buildBuzzer(),
      _buildRoomCode(),
      _buildActivatedGradient()
    ]));
  }

  void showReconnectDialog() async {
    InGameRoom? gameroom = await showDialog(
        context: context,
        builder: (context) =>
            ReconnectDialog(player: widget.inGameRoom.currentPlayer));
    if (gameroom == null) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context)
          .pushReplacementNamed("/ingame", arguments: gameroom);
    }
  }

  Widget _buildBackground() {
    return Column(
      children: [
        Expanded(
            child: Image(
          color: widget.inGameRoom.currentPlayer.team.color.withOpacity(0.2),
          image: Svg("assets/images/background_image.svg",
              color: widget.inGameRoom.currentPlayer.team.color),
          repeat: ImageRepeat.repeat,
        )),
      ],
    );
  }

  Widget _buildBuzzer() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Center(
                  child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BuzzerWidget(buzzer: widget.inGameRoom.currentPlayer),
          ))),
        ],
      ),
    );
  }

  Widget _buildInGamePlayerCard() {
    return SafeArea(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BigButton(
          rowExpanding: false,
          child: InGamePlayerCard(player: widget.inGameRoom.currentPlayer),
          onPressed: () {
            widget.inGameRoom.currentPlayer.changeTeam();
          },
        )
      ],
    ));
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
                        widget.inGameRoom.id,
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

  Widget _buildActivatedGradient() {
    return Column(
      children: [
        Expanded(
          child: AnimatedOpacity(
            opacity: widget.inGameRoom.activePlayer != null ? 1.0 : 0.0,
            duration: Duration(milliseconds: 200),
            child: Container(
              width: foregroundActive ? MediaQuery.of(context).size.width : 0,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: widget.inGameRoom.activePlayer != null
                    ? widget.inGameRoom.activePlayer!.team.gradient
                    : [Colors.transparent, Colors.transparent],
              )),
              child: Column(children: [
                Expanded(
                  child: Center(
                      child: widget.inGameRoom.activePlayer != null
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: Image(
                                      image: Svg(
                                          widget
                                              .inGameRoom.activePlayer!.avatar,
                                          source: SvgSource.network),
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    )),
                                const SizedBox(height: 20),
                                Text(widget.inGameRoom.activePlayer!.name,
                                    style: GoogleFonts.rubik(
                                        textStyle: const TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white))),
                                const SizedBox(height: 10),
                                Text(widget.inGameRoom.activePlayer!.team.name,
                                    style: GoogleFonts.rubik(
                                        textStyle: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white))),
                              ],
                            )
                          : null),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BigButton(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("Activer le buzzer",
                          style: GoogleFonts.rubik(
                              textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black))),
                    ),
                    onPressed: () {
                      widget.inGameRoom.currentPlayer.unbuzz();
                    },
                  ),
                )
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
