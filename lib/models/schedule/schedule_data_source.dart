import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'schedule.dart';

class ScheduleDataSource extends CalendarDataSource {
  ScheduleDataSource(List<Schedule> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getScheduleData(index).startTime;
  }

  @override
  DateTime getEndTime(int index) {
    return _getScheduleData(index).endTime;
  }

  @override
  String getSubject(int index) {
    return _getScheduleData(index).title;
  }

  @override
  Color getColor(int index) {
    // TODO 색을 어떻게 바꿀지 생각!
    final _random = Random();
    final color = Colors.primaries[_random.nextInt(Colors.primaries.length)];
    return color;
  }

  @override
  bool isAllDay(int index) {
    return false;
  }

  Schedule _getScheduleData(int index) {
    final dynamic meeting = appointments![index];
    late final Schedule meetingData;
    if (meeting is Schedule) {
      meetingData = meeting;
    }

    return meetingData;
  }
}
