import 'package:buzzer/components/buttons/BigButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TwoLineBigButton extends StatelessWidget {
  final String firstLine;
  final String secondLine;
  final IconData icon;
  final BorderRadius? borderRadius;
  final Function() onPressed;
  final List<Color>? colors;
  final Color textColor;

  const TwoLineBigButton(
      {super.key,
      required this.firstLine,
      required this.secondLine,
      required this.icon,
      required this.borderRadius,
      required this.onPressed,
      this.colors, 
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return BigButton(
        borderRadius: borderRadius,
        onPressed: onPressed,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors:
                      colors ?? [Colors.deepPurple, Colors.deepPurpleAccent])),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(firstLine,
                          style: GoogleFonts.rubik(
                              textStyle: TextStyle(
                                  color: textColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600))),
                      Text(secondLine,
                          style: GoogleFonts.rubik(
                              textStyle: TextStyle(
                                  color: textColor.withOpacity(0.8),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600))),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors!=null? colors![1].withOpacity(0.5): Colors.deepPurple.withOpacity(0.5)),
                  child: Icon(
                    icon,
                    color: textColor,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
