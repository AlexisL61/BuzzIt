import 'package:buzzer/components/fields/TextField.dart';
import 'package:buzzer/components/textstyle/font.dart';
import 'package:buzzer/config.dart';
import 'package:buzzer/services/api/ApiService.dart';
import 'package:buzzer/services/preferences/UserPreferencesService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MasterServerDialog extends StatefulWidget {
  const MasterServerDialog({super.key});

  @override
  State<MasterServerDialog> createState() => MasterServerDialogState();
}

class MasterServerDialogState extends State<MasterServerDialog> {
  final TextEditingController _controller = TextEditingController();
  bool testDone = false;
  bool testingConnection = false;
  bool connectionSuccess = false;

  @override
  void initState() {
    UserPreferencesService().masterServerURL.then((value) => setState(
          () {
            _controller.text = value;
          },
        ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.settings_server_title,
          style: BuzzerTextStyle.mediumRubik.copyWith(color: Colors.black)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: BuzzerTextField(
                  hint: AppLocalizations.of(context)!.settings_server_label,
                  controller: _controller,
                  onChanged: (value) {},
                ),
              ),
              IconButton(
                  onPressed: () {
                    _controller.text = BuzzerConfig.API_URL;
                  },
                  icon: const Icon(Icons.undo))
            ],
          ),
          testDone ? _buildConnectionStatus() : const SizedBox()
        ],
      ),
      actions: [
        TextButton(
          onPressed: !testingConnection
              ? () async {
                  await testConnection();
                }
              : null,
          child: Text(AppLocalizations.of(context)!.settings_server_test_connection,
              style: BuzzerTextStyle.smallRubik.copyWith(color: !testingConnection ? Colors.purple : Colors.grey)),
        ),
        TextButton(
          child: Text(AppLocalizations.of(context)!.settings_server_validate,
              style: BuzzerTextStyle.smallRubik.copyWith(color: Colors.purple)),
          onPressed: () async {
            await UserPreferencesService().setMasterServerURL(_controller.value.text);
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  Widget _buildConnectionStatus() {
    if (testingConnection) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: CircularProgressIndicator(),
      );
    } else {
      if (connectionSuccess) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(AppLocalizations.of(context)!.settings_server_success,
              style: BuzzerTextStyle.smallRubik.copyWith(color: Colors.green)),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(AppLocalizations.of(context)!.settings_server_error,
              style: BuzzerTextStyle.smallRubik.copyWith(color: Colors.red)),
        );
      }
    }
  }

  Future<void> testConnection() async {
    setState(() {
      testingConnection = true;
      connectionSuccess = false;
      testDone = true;
    });
    try {
      bool found = false;
      ApiService().getServerInfo(_controller.value.text).then((value) {
        found = true;
        setState(() {
          connectionSuccess = true;
          testingConnection = false;
        });
      });
      await Future.delayed(const Duration(seconds: 5));
      if (!found) {
        setState(() {
          connectionSuccess = false;
        });
      }
    } catch (e) {
      setState(() {
        connectionSuccess = false;
      });
    }
    setState(() {
      testingConnection = false;
    });
  }
}
