import 'package:flutter/material.dart';

class InternalSlideTransition extends StatefulWidget {
  final List<Widget> children;
  final AnimationController animationController;

  const InternalSlideTransition(
      {super.key,
      required this.children,
      required this.animationController});

  @override
  State<InternalSlideTransition> createState() =>
      _InternalSlideTransitionState();
}

class _InternalSlideTransitionState extends State<InternalSlideTransition>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: SlideTransitionDelegate(animation: widget.animationController),
      children: widget.children,
    );
  }
}

class SlideTransitionDelegate extends FlowDelegate {
  SlideTransitionDelegate({required this.animation});

  final Animation<double> animation;
  @override
  void paintChildren(FlowPaintingContext context) {
    Animation<double> tween = Tween<double>(begin: 0, end: 1).chain(CurveTween(curve: Curves.easeInOut)).animate(animation);
    var width = context.size.width;

    context.paintChild(1,
        transform:
            Matrix4.translationValues(width * (1 - tween.value), 0, 0));
    context.paintChild(0,
        transform: Matrix4.translationValues(0, 0, 0),
        opacity: 1 - tween.value*2);
  }

  @override
  bool shouldRepaint(covariant SlideTransitionDelegate oldDelegate) {
    return true;
  }
}
