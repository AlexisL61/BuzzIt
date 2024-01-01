import 'package:buzzer/components/cards/BuzzerCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A big button with rounded corners
class BigButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final BorderRadius? borderRadius;
  final bool rowExpanding;

  const BigButton(
      {super.key,
      required this.child,
      required this.onPressed,
      this.rowExpanding = true,
      this.borderRadius});

  @override
  State<BigButton> createState() => _BigButtonState();
}

class _BigButtonState extends State<BigButton> {
  bool isDown = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onPressed,
        onTapDown: (_) {
          setState(() {
            isDown = true;
          });
        },
        onTapUp: (_) {
          setState(() {
            isDown = false;
          });
        },
        child: BuzzerCard(
            rowExpanding: widget.rowExpanding,
            borderRadius: widget.borderRadius, shadowVisible: !isDown,
            child: widget.child));
  }
}
