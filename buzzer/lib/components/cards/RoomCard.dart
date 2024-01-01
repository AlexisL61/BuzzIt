import 'package:buzzer/components/cards/BuzzerCard.dart';
import 'package:buzzer/model/Room.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RoomCard extends StatefulWidget {
  final Room room;

  const RoomCard({super.key, required this.room});

  @override
  State<RoomCard> createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  @override
  Widget build(BuildContext context) {
    return BuzzerCard(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image(
              image: Svg(widget.room.host!.avatar, source: SvgSource.network),
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            )),
        const SizedBox(width: 10),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.room_title(widget.room.host!.name),
                style: GoogleFonts.rubik(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
            Text(AppLocalizations.of(context)!.profile_default_title,
                style: GoogleFonts.rubik(textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            Text(widget.room.playersNumber.toString(),
                style: GoogleFonts.rubik(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
            const SizedBox(width: 10),
            const Icon(Icons.person, size: 30)
          ],
        ),
      ]),
    ));
  }
}
