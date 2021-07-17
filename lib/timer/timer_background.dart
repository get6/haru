import 'package:flutter/material.dart';
import 'package:haru/common/color/custom_color.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class TimerBackground extends StatelessWidget {
  const TimerBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      config: CustomConfig(durations: [
        19440,
        10800,
        6000
      ], heightPercentages: [
        .03,
        .01,
        .02
      ], gradients: [
        [
          const Color.fromRGBO(72, 74, 126, 1),
          const Color.fromRGBO(125, 170, 206, 1),
          const Color.fromRGBO(184, 189, 245, 0.7)
        ],
        [
          const Color.fromRGBO(72, 74, 126, 1),
          const Color.fromRGBO(125, 170, 206, 1),
          const Color.fromRGBO(172, 182, 219, 0.7)
        ],
        [
          const Color.fromRGBO(72, 73, 126, 1),
          const Color.fromRGBO(125, 170, 206, 1),
          const Color.fromRGBO(190, 238, 246, 0.7)
        ],
      ]),
      size: const Size(double.infinity, double.infinity),
      waveAmplitude: 25,
      backgroundColor: timer_background_color,
    );
  }
}
