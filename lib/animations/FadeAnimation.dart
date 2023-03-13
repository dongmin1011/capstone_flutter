import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  const FadeAnimation({super.key, required this.delay, required this.child});

  final double delay;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PlayAnimationBuilder<Color?>(
      tween: ColorTween(begin: Colors.red, end: Colors.blue),
      duration: const Duration(seconds: 5),
      delay: const Duration(seconds: 2), // add delay
      builder: (context, value, _) {
        return Container(
          color: value,
          width: 100,
          height: 100,
        );
      },
    );
  }
}
