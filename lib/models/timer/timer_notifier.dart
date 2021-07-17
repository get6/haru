import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TimerModel extends ChangeNotifier {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  Duration _currentDuration = Duration.zero;
  TimerState state;
  int maxTime = (60 * 59) + 59;

  TimerModel([this.state = TimerState.ready]);

  void changeState(TimerState state) {
    this.state = state;
    notifyListeners();
  }

  void _onTick(Timer timer) {
    _currentDuration = _stopwatch.elapsed;
    if (maxTime == _currentDuration.inSeconds) {
      pause();
    } else {
      notifyListeners();
    }
  }

  void start() {
    if (maxTime == _stopwatch.elapsed.inSeconds) {
      _timer = null;
      _stopwatch.reset();
      _currentDuration = Duration.zero;
      // TODO 알람
    }

    _timer = Timer.periodic(const Duration(seconds: 1), _onTick);
    _stopwatch.start();
    changeState(TimerState.running);
  }

  void pause() {
    _timer?.cancel();
    _timer = null;
    _stopwatch.stop();
    _currentDuration = _stopwatch.elapsed;
    changeState(TimerState.paused);
  }

  void resume() {
    changeState(TimerState.running);
  }

  void reset() {
    _timer?.cancel();
    _timer = null;
    _stopwatch.reset();
    _currentDuration = Duration.zero;
    changeState(TimerState.ready);
  }

  String getTimeText() {
    final String minutes =
        (_currentDuration.inMinutes % 60).floor().toString().padLeft(2, '0');
    final String seconds =
        (_currentDuration.inSeconds % 60).floor().toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }
}

enum TimerState { ready, paused, running, finished }

final timerProvider = ChangeNotifierProvider<TimerModel>((ref) => TimerModel());
