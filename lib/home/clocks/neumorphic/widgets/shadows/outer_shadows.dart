import 'package:flutter/material.dart';
import 'package:haru/common/color/custom_color.dart';

class OuterShadows extends StatelessWidget {
  final double unit;
  final double bevel;
  final Offset blurOffset;

  OuterShadows({
    Key? key,
    required this.unit,
    this.bevel = 10.0,
  })  : blurOffset = Offset(bevel / 2, bevel / 2),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: bevel,
            offset: -blurOffset,
            color: Colors.grey[200]!,
          ),
          BoxShadow(
            blurRadius: bevel,
            offset: blurOffset,
            color: Colors.grey[300]!,
          )
        ],
      ),
    );
  }
}
