import 'package:flutter/material.dart';

class OpacityTransition extends StatefulWidget {
  final List<Widget> children;
  final int selectedChild;

  const OpacityTransition(
      {super.key, required this.children, required this.selectedChild});

  @override
  State<OpacityTransition> createState() => _OpacityTransitionState();
}

class _OpacityTransitionState extends State<OpacityTransition>
    with SingleTickerProviderStateMixin {
  late int oldChild;
  late int currentOldChild;
  late AnimationController animationController;

  @override
  void initState() {
    oldChild = widget.selectedChild;
    currentOldChild = widget.selectedChild;
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
      animationController.reset();
      animationController.forward();
      currentOldChild = oldChild;
      oldChild = widget.selectedChild;
    }

    return Flow(
      delegate: SlideTransitionDelegate(
          animation: animationController,
          selectedChild: widget.selectedChild,
          oldChild: currentOldChild),
      children: widget.children,
    );
  }
}

class SlideTransitionDelegate extends FlowDelegate {
  SlideTransitionDelegate(
      {required this.animation,
      required this.selectedChild,
      required this.oldChild});

  final Animation<double> animation;
  final int selectedChild;
  final int oldChild;
  @override
  void paintChildren(FlowPaintingContext context) {
    Animation<double> tween = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(animation);
    if (oldChild != selectedChild) {
      context.paintChild(oldChild,
          transform: Matrix4.translationValues(0, 0, 0),
          opacity: 1 - tween.value);
    }

    context.paintChild(selectedChild,
        transform: Matrix4.translationValues(0, 0, 0), opacity: tween.value);
  }

  @override
  bool shouldRepaint(covariant SlideTransitionDelegate oldDelegate) {
    return true;
  }

  @override
  Size getSize(BoxConstraints constraints) { 
    return constraints.biggest;
  }
}
