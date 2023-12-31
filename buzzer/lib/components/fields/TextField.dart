import 'package:buzzer/components/textstyle/font.dart';
import 'package:flutter/material.dart';

class BuzzerTextField extends StatefulWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? hint;

  const BuzzerTextField({super.key, this.controller, this.onChanged, this.hint});

  @override
  State<BuzzerTextField> createState() => _BuzzerTextFieldState();
}

class _BuzzerTextFieldState extends State<BuzzerTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          hintText: widget.hint,
          labelStyle: BuzzerTextStyle.mediumRubik
              .copyWith(color: Colors.deepPurpleAccent),
        ),
        style: BuzzerTextStyle.mediumRubik
            .copyWith(color: Colors.deepPurpleAccent),
        onChanged: widget.onChanged);
  }
}
