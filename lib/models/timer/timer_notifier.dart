import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TimerModel extends ChangeNotifier {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  Duration _currentDuration = Duration.zero;
  TimerState _state;
  int maxTime = (60 * 59) + 59;

  TimerModel([this._state = TimerState.ready]);

  TimerState get state => _state;

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
    _stopwatch.start();
    _state = TimerState.running;
    notifyListeners();
    _timer = Timer.periodic(const Duration(seconds: 1), _onTick);
  }

  void pause() {
    _timer?.cancel();
    _timer = null;
    _stopwatch.stop();
    _currentDuration = _stopwatch.elapsed;
    _state = TimerState.paused;
    notifyListeners();
  }

  void resume() {
    _state = TimerState.running;
    notifyListeners();
  }

  void reset() {
    _timer?.cancel();
    _timer = null;
    _stopwatch.reset();
    _currentDuration = Duration.zero;
    _state = TimerState.ready;
    notifyListeners();
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
