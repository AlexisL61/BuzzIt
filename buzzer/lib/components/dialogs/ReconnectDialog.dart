import 'package:buzzer/model/InGame/InGameRoom.dart';
import 'package:buzzer/model/Player.dart';
import 'package:buzzer/services/connection/RoomConnection.dart';
import 'package:buzzer/services/preferences/UserPreferencesService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReconnectDialog extends StatefulWidget {
  final Player player;

  const ReconnectDialog({super.key, required this.player});

  @override
  State<ReconnectDialog> createState() => _ReconnectDialogState();
}

class _ReconnectDialogState extends State<ReconnectDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.reconnect_dialog_title),
      content: Text(AppLocalizations.of(context)!.reconnect_dialog_text),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(null);
            },
            child: Text(AppLocalizations.of(context)!.reconnect_dialog_no)),
        TextButton(
            onPressed: () async {
              String? roomCode = await UserPreferencesService().latestRoomCode;
              String? reconnectionToken =
                  await UserPreferencesService().reconnectionToken;
              print(roomCode);
              print(reconnectionToken);
              if (roomCode == null || reconnectionToken == null) {
                return;
              }
              InGameRoom? gameroom = await RoomConnectionService()
                  .reconnectToRoom(roomCode, reconnectionToken, widget.player);
              if (gameroom != null) {
                Navigator.of(context).pop(gameroom);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppLocalizations.of(context)!.reconnect_dialog_error)));
                Navigator.of(context).pop(null);
              }
            },
            child: Text(AppLocalizations.of(context)!.reconnect_dialog_yes)),
      ],
    );
  }
}
