import 'package:buzzer/model/InGame/InGameRoom.dart';
import 'package:buzzer/model/Player.dart';
import 'package:buzzer/services/connection/RoomConnection.dart';
import 'package:buzzer/services/preferences/UserPreferencesService.dart';
import 'package:flutter/material.dart';

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
      title: const Text("Connexion perdue"),
      content: const Text("Voulez-vous vous reconnecter ?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(null);
            },
            child: const Text("Non")),
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
                    SnackBar(content: Text("Impossible de se reconnecter")));
                Navigator.of(context).pop(null);
              }
            },
            child: const Text("Oui")),
      ],
    );
  }
}
