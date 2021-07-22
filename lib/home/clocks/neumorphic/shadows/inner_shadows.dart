import 'package:flutter/material.dart';

class InnerShadows extends StatelessWidget {
  final double unit;
  const InnerShadows({Key? key, required this.unit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.5 * unit),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
              gradient: RadialGradient(
                colors: [
                  Colors.white.withOpacity(0.0),
                  Colors.grey[400]!,
                ],
                center: const AlignmentDirectional(.1, .1),
                focal: const AlignmentDirectional(.0, .0),
                radius: .65,
                focalRadius: .001,
                stops: const [.3, 1.0],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
              gradient: RadialGradient(
                colors: [
                  Colors.white.withOpacity(0.0),
                  Colors.white,
                ],
                center: const AlignmentDirectional(-0.1, -0.1),
                focal: const AlignmentDirectional(0.0, 0.0),
                radius: .67,
                focalRadius: .001,
                stops: const [.75, 1.0],
              ),
            ),
          )
        ],
      ),
    );
  }
}
