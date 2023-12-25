import 'package:buzzer/components/buttons/BigButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OneLineIconTextButton extends StatelessWidget {
  final List<Color> colors;
  final Color iconBackgroundColor;
  final IconData icon;
  final Function() onPressed;
  final String text;

  const OneLineIconTextButton(
      {super.key,
      required this.colors,
      required this.iconBackgroundColor, 
      required this.icon, 
      required this.onPressed,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return BigButton(
        child: Container(
          decoration: BoxDecoration(gradient: LinearGradient(colors: colors)),
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: iconBackgroundColor),
                    child: Icon(icon, color: Colors.white)),
                SizedBox(height: 10),
                Text(text,
                    style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600))),
              ])),
        ),
        onPressed: onPressed);
  }
}
