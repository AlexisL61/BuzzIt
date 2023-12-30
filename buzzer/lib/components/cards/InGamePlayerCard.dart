import 'package:buzzer/components/cards/BuzzerCard.dart';
import 'package:buzzer/config.dart';
import 'package:buzzer/model/InGame/BuzzerTeam.dart';
import 'package:buzzer/model/InGame/InGamePlayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class InGamePlayerCard extends StatefulWidget {
  final InGamePlayer player;

  const InGamePlayerCard({super.key, required this.player});

  @override
  State<InGamePlayerCard> createState() => _InGamePlayerCardState();
}

class _InGamePlayerCardState extends State<InGamePlayerCard> {
  @override
  Widget build(BuildContext context) {
    return BuzzerCard(
      rowExpanding: false,
        child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors:widget.player.team.gradient)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image(
                image: Svg(widget.player.avatar, source: SvgSource.network),
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              )),
          const SizedBox(width: 10),
              Text(widget.player.team.name,
                  style: GoogleFonts.rubik(
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white))
          )
        ]),
      ),
    ));
  }
}
