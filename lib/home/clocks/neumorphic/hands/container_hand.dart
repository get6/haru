import 'package:flutter/material.dart';
import 'package:haru/home/clocks/neumorphic/hands/hand.dart';

class ContainerHand extends Hand {
  /// The child widget used as the clock hand and rotated by [angleRadians].
  final Widget? child;

  const ContainerHand({
    required Color color,
    required double size,
    required double angleRadians,
    this.child,
  }) : super(
          color: color,
          size: size,
          angleRadians: angleRadians,
        );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: Transform.rotate(
          angle: angleRadians,
          child: Transform.scale(
            scale: size,
            child: Container(
              color: color,
              child: Center(
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
