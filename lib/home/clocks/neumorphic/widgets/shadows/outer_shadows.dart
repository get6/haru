import 'package:flutter/material.dart';
import 'package:haru/common/color/custom_color.dart';

class OuterShadows extends StatelessWidget {
  final double unit;

  const OuterShadows({Key? key, required this.unit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: neumorphicTheme[neumorphicColor.background],
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            offset: Offset(-unit / 2, -unit / 2),
            blurRadius: 1.5 * unit,
          ),
          BoxShadow(
            color: neumorphicTheme[neumorphicColor.divider]!,
            offset: Offset(unit / 2, unit / 2),
            blurRadius: 1.5 * unit,
          ),
        ],
      ),
    );
  }
}
