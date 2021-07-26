import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show radians;
import 'widgets/neumorphic_clock_body.dart';
import 'widgets/neumorphic_clock_face.dart';

/// Total distance traveled by a second or a minute hand, each second or minute,
/// respectively.
final radiansPerTick = radians(360 / 60);

/// Total distance traveled by an hour hand, each hour, in radians.
final radiansPerHour = radians(360 / 12);

const hourWidth = 0.16;

class NeumorphicClock extends StatelessWidget {
  const NeumorphicClock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 7 / 6,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final unit = constraints.biggest.width / 31;
          return Container(
            padding: EdgeInsets.all(0.5 * unit),
            child: Stack(
              children: [
                NeumorphicClockBody(unit: unit), // 상태가 변하지 않는 곳
                NeumorphicClockFace(unit: unit), // 1초마다 바뀌는 곳
              ],
            ),
          );
        },
      ),
    );
  }
}
