import 'package:buzzer/config.dart';
import 'package:buzzer/services/preferences/SavedPlayerService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileDialog extends StatefulWidget {
  const ProfileDialog({super.key});

  @override
  State<ProfileDialog> createState() => _ProfileDialogState();
}

class _ProfileDialogState extends State<ProfileDialog> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = SavedPlayerService.savedPlayer.name;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        InkWell(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image(
                  image: Svg(
                      SavedPlayerService.savedPlayer.avatar,
                      source: SvgSource.network),
                  fit: BoxFit.cover,
                  width: 120,
                  height: 120,
                )),
          ),
          onTap: () async {
            await SavedPlayerService.randomAvatar();
            setState(() {});
          },
        ),
        TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Entrez votre nom',
              labelStyle: GoogleFonts.rubik(
                  textStyle: const TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.w600)),
            ),
            style: GoogleFonts.rubik(
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600)),
            onChanged: (String value) async {
              SavedPlayerService.savedPlayer.name = value;
              await SavedPlayerService.savePlayer(SavedPlayerService.savedPlayer);
            }),
      ]),
    );
  }
}
