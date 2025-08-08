import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// ignore: must_be_immutable
class StaggeredColumnAnimation extends StatelessWidget {
  final List<Widget> children;
  final Duration duration;
  final double verticalOffset;
  CrossAxisAlignment? crossAxisAlignment;
  MainAxisAlignment? mainAxisAlignment;

  StaggeredColumnAnimation({
    super.key,
    required this.children,
    this.duration = const Duration(milliseconds: 300),
    this.verticalOffset = 50.0,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: Column(
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
        children: AnimationConfiguration.toStaggeredList(
          duration: duration,
          childAnimationBuilder: (widget) => SlideAnimation(
            verticalOffset: verticalOffset,
            child: FadeInAnimation(child: widget),
          ),
          children: children,
        ),
      ),
    );
  }
}
