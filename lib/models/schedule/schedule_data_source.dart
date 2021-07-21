import 'package:flutter/material.dart';
import 'package:haru/common/color/custom_color.dart';
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
    return main_color;
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
