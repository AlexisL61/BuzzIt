import 'package:buzzer/components/buttons/BigButton.dart';
import 'package:buzzer/components/dialogs/SettingsDialog.dart';
import 'package:buzzer/components/textstyle/font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ServerSettingsComponent extends StatefulWidget {
  const ServerSettingsComponent({super.key});

  @override
  State<ServerSettingsComponent> createState() => _ServerSettingsComponentState();
}

class _ServerSettingsComponentState extends State<ServerSettingsComponent> {
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
                  Text(AppLocalizations.of(context)!.settings_server_title, style: BuzzerTextStyle.mediumRubik.copyWith(color: Colors.black)),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios)
                ],
              )),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => const MasterServerDialog(),
            );
          }),
    );
  }
}
