import 'package:flutter/material.dart';

class SpinnerGem extends StatelessWidget {
  const SpinnerGem({
    super.key,
    this.degree = 0,
    this.top,
    this.right,
    this.bottom,
    this.left,
  });

  final int degree;
  final double? top;
  final double? right;
  final double? bottom;
  final double? left;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      bottom: bottom,
      left: left,
      child: RotationTransition(
        turns: AlwaysStoppedAnimation(degree / 360),
        child: Image.asset(
          'assets/gem.png',
          height: 30,
        ),
      ),
    );
  }
}
