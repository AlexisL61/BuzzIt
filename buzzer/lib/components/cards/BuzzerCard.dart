import 'package:flutter/material.dart';

enum BuzzerCardStyle {
  WHITE,
  PURPLE;
}

class BuzzerCard extends StatefulWidget {
  final BorderRadius? borderRadius;
  final Widget child;
  final BuzzerCardStyle? style;
  final bool rowExpanding;
  final bool shadowVisible;

  const BuzzerCard(
      {super.key,
      required this.child,
      this.borderRadius,
      this.style,
      this.rowExpanding = true,
      this.shadowVisible = true});

  @override
  State<BuzzerCard> createState() => _BuzzerCardState();

  static Widget buildWhiteCard(
      {required Widget child, BorderRadius? borderRadius}) {
    return BuzzerCard(
        child: child, borderRadius: borderRadius, style: BuzzerCardStyle.WHITE);
  }

  static Widget buildPurpleCard(
      {required Widget child, BorderRadius? borderRadius}) {
    return BuzzerCard(
        child: child,
        borderRadius: borderRadius,
        style: BuzzerCardStyle.PURPLE);
  }
}

class _BuzzerCardState extends State<BuzzerCard> with TickerProviderStateMixin {
  late AnimationController animationController;
  bool oldShadowState = false;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 50), vsync: this);

    animationController.addListener(() {
      setState(() {});
    });

    oldShadowState = widget.shadowVisible;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (oldShadowState != widget.shadowVisible) {
      if (widget.shadowVisible) {
        animationController.reverse();
      } else {
        animationController.forward();
      }
      oldShadowState = widget.shadowVisible;
    }
    return Row(
      mainAxisSize: widget.rowExpanding ? MainAxisSize.max : MainAxisSize.min,
      children: [
        widget.rowExpanding
            ? Expanded(
                child: Container(
                decoration: widget.style == BuzzerCardStyle.PURPLE
                    ? buildPurpleBoxDecoration()
                    : buildWhiteBoxDecoration(),
                child: ClipRRect(
                    borderRadius:
                        widget.borderRadius ?? BorderRadius.circular(10),
                    child: widget.child),
              ))
            : Container(
                decoration: widget.style == BuzzerCardStyle.PURPLE
                    ? buildPurpleBoxDecoration()
                    : buildWhiteBoxDecoration(),
                child: ClipRRect(
                    borderRadius:
                        widget.borderRadius ?? BorderRadius.circular(10),
                    child: widget.child),
              ),
      ],
    );
  }

  BoxDecoration buildPurpleBoxDecoration() {
    return BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.deepPurpleAccent]),
        borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
        boxShadow: [_buildBoxShadow()]);
  }

  BoxDecoration buildWhiteBoxDecoration() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
        boxShadow: [_buildBoxShadow()]);
  }

  BoxShadow _buildBoxShadow() {
    return BoxShadow(
      color: Colors.black.withOpacity((1-animationController.value) * 0.1 + 0.2),
      spreadRadius: 5,
      blurRadius: 10,
      offset: Offset(0, 0),
    );
  }
}
