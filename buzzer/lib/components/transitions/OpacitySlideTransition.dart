import 'package:flutter/material.dart';

class OpacitySlideTransition extends StatefulWidget {
  final List<Widget> children;
  final int selectedChild;

  const OpacitySlideTransition(
      {super.key, required this.children, required this.selectedChild});

  @override
  State<OpacitySlideTransition> createState() => _OpacitySlideTransitionState();
}

class _OpacitySlideTransitionState extends State<OpacitySlideTransition>
    with SingleTickerProviderStateMixin {
  late int oldChild;
  late AnimationController animationController;

  @override
  void initState() {
    oldChild = widget.selectedChild;
    animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);

    animationController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (oldChild != widget.selectedChild) {
      if (oldChild < widget.selectedChild) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
      oldChild = widget.selectedChild;
    }

    return Flow(
      delegate: SlideTransitionDelegate(
          animation: animationController, selectedChild: widget.selectedChild),
      children: widget.children,
    );
  }
}

class SlideTransitionDelegate extends FlowDelegate {
  SlideTransitionDelegate(
      {required this.animation, required this.selectedChild});

  final Animation<double> animation;
  final int selectedChild;
  @override
  void paintChildren(FlowPaintingContext context) {
    Animation<double> tween = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(animation);
    var width = context.size.width;

    int opacityChild;
    int movingChild;

    if (animation.status == AnimationStatus.forward ||
        animation.status == AnimationStatus.completed) {
      opacityChild = selectedChild - 1;
      movingChild = selectedChild;
    } else {
      opacityChild = selectedChild;
      movingChild = selectedChild + 1;
    }
    context.paintChild(opacityChild,
        transform: Matrix4.translationValues(0, 0, 0),
        opacity: 1 - tween.value);

    context.paintChild(movingChild,
        transform: Matrix4.translationValues(width * (1 - tween.value), 0, 0));
  }

  @override
  bool shouldRepaint(covariant SlideTransitionDelegate oldDelegate) {
    return true;
  }
}
