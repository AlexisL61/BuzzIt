import 'package:buzzer/components/buttons/BigButton.dart';
import 'package:buzzer/components/dialogs/SettingsDialog.dart';
import 'package:buzzer/components/fields/TextField.dart';
import 'package:buzzer/components/textstyle/font.dart';
import 'package:buzzer/config.dart';
import 'package:buzzer/model/ServerInfo.dart';
import 'package:buzzer/services/api/ApiService.dart';
import 'package:buzzer/services/preferences/UserPreferencesService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServerSettingsComponent extends StatefulWidget {
  const ServerSettingsComponent({super.key});

  @override
  State<ServerSettingsComponent> createState() =>
      _ServerSettingsComponentState();
}

class _ServerSettingsComponentState extends State<ServerSettingsComponent> {
  TextEditingController _controller = TextEditingController();
  bool testingConnection = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BigButton(
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.settings),
                  const SizedBox(width: 10),
                  Text("Serveur de jeu",
                      style: BuzzerTextStyle.mediumRubik
                          .copyWith(color: Colors.black)),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios)
                ],
              )),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => MasterServerDialog(),
            );
          }),
    );
  }
}
