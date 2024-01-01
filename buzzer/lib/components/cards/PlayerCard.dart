import 'package:buzzer/components/cards/BuzzerCard.dart';
import 'package:buzzer/model/Player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlayerCard extends StatefulWidget {
  final Player player;

  const PlayerCard({super.key, required this.player});

  @override
  State<PlayerCard> createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  @override
  Widget build(BuildContext context) {
    print(widget.player.avatar);
    return BuzzerCard(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image(image: Svg(widget.player.avatar, source: SvgSource.network), width: 60, height: 60)),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.player.name,
                style: GoogleFonts.rubik(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
            Text(AppLocalizations.of(context)!.profile_default_title,
                style: GoogleFonts.rubik(textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
          ],
        )
      ]),
    ));
  }
}
