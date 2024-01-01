import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuzzerTextStyle {
  static TextStyle mediumRubik = GoogleFonts.rubik(
      textStyle: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white)); 

  static TextStyle smallRubik = GoogleFonts.rubik(
      textStyle: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white));
  
  static TextStyle bigRubik = GoogleFonts.rubik(
      textStyle: const TextStyle(
          fontSize: 30, fontWeight: FontWeight.w600, color: Colors.white));
}