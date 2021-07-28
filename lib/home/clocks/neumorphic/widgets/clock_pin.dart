import 'package:flutter/material.dart';

class ClockPin extends StatelessWidget {
  final double unit;
  const ClockPin({Key? key, required this.unit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 0.8 * unit,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red[400],
        ),
      ),
    );
  }
}
