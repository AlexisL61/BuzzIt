import 'package:buzzer/components/cards/BigCard.dart';
import 'package:buzzer/model/Player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlayerCard extends StatefulWidget {
  final Player player;

  const PlayerCard({super.key, required this.player});

  @override
  State<PlayerCard> createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  @override
  Widget build(BuildContext context) {
    return BigCard(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    widget.player.image,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  )),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.player.name,
                      style: GoogleFonts.rubik(
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600))),
                  Text("Le magicien",
                      style: GoogleFonts.rubik(
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600))),
                ],
              )
            ]),
          ));
  }
}