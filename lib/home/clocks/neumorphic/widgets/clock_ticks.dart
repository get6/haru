import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

import '../neumorphic_clock.dart';

class ClockTicks extends StatelessWidget {
  final double unit;
  const ClockTicks({Key? key, required this.unit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO 숫자 아래로 향하는 걸 위로 향하게
    final today = DateTime.now();
    return Stack(
      children: [
        for (int i = 0; i < 60; i++)
          // if (i % 15 == 0)
          Center(
            child: Transform.rotate(
              angle: radians(360 / 60 * i),
              child: Transform.translate(
                offset: Offset(0, -10.7 * unit),
                child: Container(
                  color: i % 5 == 0 ? Colors.black54 : Colors.grey[400],
                  height: 1.2 * unit,
                  width: i % 5 == 0 ? hourWidth * unit : 0.12 * unit,
                ),
              ),
            ),
          ),
        for (int i = 0; i < 12; i++)
          Center(
            child: Transform.rotate(
              angle: radians(360 / 12 * i),
              child: Transform.translate(
                offset: Offset(0, i % 6 == 0 ? -12 * unit : -12 * unit),
                child: Text(
                  '${today.hour >= 12 ? i + 12 : i}',
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
