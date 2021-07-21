import 'dart:async';

import 'package:flutter/material.dart';
import 'package:haru/common/const_values.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TimerModel extends ChangeNotifier {
  Duration _now = const Duration(minutes: 59, seconds: 59);
  int minTime = 0;
  Timer? _timer;
  TimerState _state;

  TimerModel([this._state = TimerState.ready]);

  TimerState get state => _state;

  void _onTick(Timer timer) {
    _now = Duration(seconds: _now.inSeconds - 1);
    if (minTime == _now.inSeconds) {
      pause();
    } else {
      notifyListeners();
    }
  }

  void start() {
    if (minTime == _now.inSeconds) {
      _timer = null;
      _now = const Duration(minutes: 59, seconds: 59);
      // TODO 알람
    }
    _state = TimerState.running;
    notifyListeners();
    _timer = Timer.periodic(const Duration(seconds: 1), _onTick);
  }

  void pause() {
    _timer?.cancel();
    _state = TimerState.paused;
    notifyListeners();
  }

  void resume() {
    _state = TimerState.running;
    notifyListeners();
  }

  void reset() {
    _timer?.cancel();
    _now = const Duration(minutes: 59, seconds: 59);
    _state = TimerState.ready;
    notifyListeners();
  }

  String getTimeText() {
    final String minutes = padLeftForTime((_now.inMinutes % 60).floor());
    final String seconds = padLeftForTime((_now.inSeconds % 60).floor());

    return '$minutes:$seconds';
  }
}

enum TimerState { ready, paused, running, finished }

final timerProvider = ChangeNotifierProvider<TimerModel>((ref) => TimerModel());
