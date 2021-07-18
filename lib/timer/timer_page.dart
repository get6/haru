import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:haru/common/color/custom_color.dart';
import 'package:haru/models/timer/timer_notifier.dart';
import 'package:haru/timer/timer_actions.dart';
import 'package:haru/timer/timer_background.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TimerPage extends ConsumerWidget {
  static const routeName = '/timer';
  const TimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final timerModel = watch(timerProvider);
    return Scaffold(
      appBar: AppBar(backgroundColor: timer_background_color, elevation: 0),
      body: Stack(
        children: [
          const TimerBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 100,
                ),
                child: Text(
                  timerModel.getTimeText(),
                  style: const TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
              ),
              const TimerActions(),
            ],
          ),
        ],
      ),
    );
  }
}
