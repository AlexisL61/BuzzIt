import 'package:buzzer/components/cards/BuzzerCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A big button with rounded corners
class BigButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final BorderRadius? borderRadius;

  const BigButton(
      {super.key,
      required this.child,
      required this.onPressed,
      this.borderRadius});

  @override
  State<BigButton> createState() => _BigButtonState();
}

class _BigButtonState extends State<BigButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        padding: EdgeInsets.all(0),
        onPressed: widget.onPressed,
        child:
            BuzzerCard(child: widget.child, borderRadius: widget.borderRadius));
  }
}
