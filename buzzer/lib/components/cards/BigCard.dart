import 'package:flutter/material.dart';

enum BigCardStyle {
  WHITE,
  PURPLE;
}

class BigCard extends StatelessWidget {
  final BorderRadius? borderRadius;
  final Widget child;
  final BigCardStyle? style;

  const BigCard(
      {super.key, required this.child, this.borderRadius, this.style});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: style == BigCardStyle.PURPLE
                ? buildPurpleBoxDecoration()
                : buildWhiteBoxDecoration(),
            child: ClipRRect(
                borderRadius: borderRadius ?? BorderRadius.circular(10),
                child: child),
          ),
        ),
      ],
    );
  }

  BoxDecoration buildPurpleBoxDecoration() {
    return BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.deepPurpleAccent]),
        borderRadius: borderRadius ?? BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, 0),
          ),
        ]);
  }

  BoxDecoration buildWhiteBoxDecoration() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, 0),
          ),
        ]);
  }

  static Widget buildWhiteCard(
      {required Widget child, BorderRadius? borderRadius}) {
    return BigCard(
        child: child, borderRadius: borderRadius, style: BigCardStyle.WHITE);
  }

  static Widget buildPurpleCard(
      {required Widget child, BorderRadius? borderRadius}) {
    return BigCard(
        child: child, borderRadius: borderRadius, style: BigCardStyle.PURPLE);
  }
}
