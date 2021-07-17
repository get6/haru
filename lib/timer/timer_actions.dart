import 'package:flutter/material.dart';
import 'package:haru/common/color/custom_color.dart';
import 'package:haru/models/timer/timer_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TimerActions extends ConsumerWidget {
  TimerActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final TimerModel timerState = watch(timerProvider);
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      if (timerState.state == TimerState.ready) ...[
        timerFAB(Icons.play_arrow, timerState.start),
      ],
      if (timerState.state == TimerState.running) ...[
        timerFAB(Icons.pause, timerState.pause),
        timerFAB(Icons.replay, timerState.reset),
      ],
      if (timerState.state == TimerState.paused) ...[
        timerFAB(Icons.play_arrow, timerState.start),
        timerFAB(Icons.replay, timerState.reset),
      ],
      if (timerState.state == TimerState.finished) ...[
        timerFAB(Icons.replay, timerState.reset),
      ]
    ]);
  }

  Widget timerFAB(IconData iconData, Function onPressed) {
    return FloatingActionButton(
      onPressed: () => onPressed(),
      backgroundColor: timer_button_color,
      child: Icon(iconData, color: Colors.white),
    );
  }
}
