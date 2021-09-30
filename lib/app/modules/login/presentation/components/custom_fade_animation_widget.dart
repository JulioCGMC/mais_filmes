import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class CustomFadeAnimationWidget extends StatelessWidget {
  final double delay;
  final Widget child;

  const CustomFadeAnimationWidget({Key? key, required this.delay, 
    required this.child, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
    // return CustomAnimation(
    //   delay: Duration(milliseconds: (500 * delay).round()),
    //   duration: const Duration(milliseconds: 500),
    //   tween: Tween<double>(begin: -30.0, end: 0.0),
    //   child: child,
    //   builder: (context, child, double value) => Transform.translate(
    //     offset: Offset(0, value), 
    //     child: child
    //   ),
    // );
  }
}