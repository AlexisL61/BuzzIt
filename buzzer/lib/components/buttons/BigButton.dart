import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A big button with rounded corners
class BigButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final BorderRadius? borderRadius;

  const BigButton({super.key, required this.child, required this.onPressed, this.borderRadius});

  @override
  State<BigButton> createState() => _BigButtonState();
}

class _BigButtonState extends State<BigButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        padding: EdgeInsets.all(0),
        onPressed: widget.onPressed,
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: widget.borderRadius?? BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ]),
                child: ClipRRect(
                    borderRadius: widget.borderRadius?? BorderRadius.circular(10),
                    child: widget.child),
              ),
            ),
          ],
        ));
  }
}
