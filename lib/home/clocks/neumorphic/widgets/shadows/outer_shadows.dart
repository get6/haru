import 'package:flutter/material.dart';

class OuterShadows extends StatelessWidget {
  final double unit;
  const OuterShadows({Key? key, required this.unit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[400]!,
              offset: Offset(-unit / 4, -unit / 4),
              blurRadius: .2 * unit,
            ),
            BoxShadow(
              color: Colors.grey[400]!,
              offset: Offset(unit / 4, unit / 4),
              blurRadius: .2 * unit,
            )
          ]),
    );
  }
}
