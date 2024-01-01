import 'package:buzzer/components/buttons/OneLineIconTextButton.dart';
import 'package:buzzer/components/buttons/TwoLineBigButton.dart';
import 'package:buzzer/components/cards/PlayerCard.dart';
import 'package:buzzer/components/dialogs/ProfileDialog.dart';
import 'package:buzzer/components/transitions/OpacitySlideTransition.dart';
import 'package:buzzer/model/InGame/InGameRoom.dart';
import 'package:buzzer/pages/menu/components/GameCodeComponent.dart';
import 'package:buzzer/services/connection/RoomConnection.dart';
import 'package:buzzer/services/preferences/SavedPlayerService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainMenuPage extends StatefulWidget {
  static const String route = "/";

  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  AnimationController? animationController;

  int selectedChild = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: selectedChild == 0,
      onPopInvoked: handlePop,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(children: [
              Column(
                children: [
                  _buildUpperBackground(),
                  Expanded(
                      child: Image(
                    color: Colors.deepPurpleAccent.withOpacity(0.2),
                    image: const Svg("assets/images/background_image.svg", color: Colors.deepPurpleAccent),
                    repeat: ImageRepeat.repeat,
                  )),
                  _buildBottomBackground()
                ],
              ),
              SafeArea(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildIntro(),
                  _buildPlayerInfo(),
                  Expanded(
                    child: OpacitySlideTransition(selectedChild: selectedChild, children: [
                      Column(children: [
                        const Spacer(),
                        _buildCreateGameButton(),
                        const SizedBox(height: 40),
                        _buildJoinGameButton(),
                        const Spacer(),
                        _buildInventoryAndSettings(),
                        const SizedBox(height: 20),
                      ]),
                      GameCodeComponent(
                        goingBack: () {
                          setState(() {
                            selectedChild = 0;
                          });
                        },
                      ),
                    ]),
                  )
                ],
              ))
            ])));
  }

  Widget _buildIntro() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.main_menu_title.toUpperCase(),
                style: GoogleFonts.rubik(
                    textStyle:
                        TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 20, fontWeight: FontWeight.w600))),
            Text(AppLocalizations.of(context)!.main_menu_subtitle.toUpperCase(),
                style: GoogleFonts.rubik(
                    textStyle: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w600))),
          ],
        )
      ]),
    );
  }

  Widget _buildUpperBackground() {
    return Container(
      height: 220,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.deepPurple, Colors.deepPurpleAccent],
        ),
      ),
    );
  }

  Widget _buildPlayerInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: PlayerCard(player: SavedPlayerService.savedPlayer),
    );
  }

  Widget _buildCreateGameButton() {
    return Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: TwoLineBigButton(
            firstLine: AppLocalizations.of(context)!.main_menu_create_room_title.toUpperCase(),
            secondLine: AppLocalizations.of(context)!.main_menu_create_room_subtitle.toUpperCase(),
            icon: Icons.add,
            borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), topRight: Radius.circular(20)),
            onPressed: () async {
              InGameRoom? room = await RoomConnectionService().createRoom(SavedPlayerService.savedPlayer);
              if (room != null) {
                Navigator.pushNamed(context, '/ingame', arguments: room);
              }
            }));
  }

  Widget _buildJoinGameButton() {
    return Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: TwoLineBigButton(
            firstLine: AppLocalizations.of(context)!.main_menu_join_room_title.toUpperCase(),
            secondLine: AppLocalizations.of(context)!.main_menu_join_room_subtitle.toUpperCase(),
            icon: Icons.send,
            borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), topRight: Radius.circular(20)),
            onPressed: () {
              setState(() {
                selectedChild = 1;
              });
            }));
  }

  Widget _buildInventoryAndSettings() {
    return Row(
      children: [Expanded(child: _buildInventoryButton()), Expanded(child: _buildSettingsButton())],
    );
  }

  Widget _buildInventoryButton() {
    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 8.0),
        child: OneLineIconTextButton(
            colors: const [Colors.deepPurple, Color.fromARGB(255, 113, 67, 219)],
            iconBackgroundColor: Colors.deepPurpleAccent,
            icon: Icons.badge,
            onPressed: () async {
              await showDialog(context: context, builder: (BuildContext context) => const ProfileDialog());
              setState(() {});
            },
            text: AppLocalizations.of(context)!.main_menu_profile_title.toUpperCase()));
  }

  Widget _buildSettingsButton() {
    return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 16.0),
        child: OneLineIconTextButton(
            colors: const [Color.fromARGB(255, 113, 67, 219), Colors.deepPurpleAccent],
            iconBackgroundColor: Colors.deepPurpleAccent,
            icon: Icons.settings,
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            text: AppLocalizations.of(context)!.main_menu_settings_title.toUpperCase()));
  }

  Widget _buildBottomBackground() {
    return Container(
      height: 0,
      decoration: const BoxDecoration(color: Colors.deepPurpleAccent),
    );
  }

  void handlePop(_){
    if(selectedChild == 1){
      setState(() {
        selectedChild = 0;
      });
    }
  }
}
