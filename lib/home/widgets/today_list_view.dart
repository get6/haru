import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haru/common/color/custom_color.dart';
import 'package:haru/common/const_values.dart';
import 'package:haru/models/schedule/schedule.dart';
import 'package:haru/models/schedule/schedule_data_source.dart';
import 'package:haru/models/schedule/schedule_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TodayListView extends ConsumerWidget {
  TodayListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final scheduleNotifier = watch(scheduleProvider);
    final schedules = scheduleNotifier.fetchTodaySchedules();
    return SfCalendar(
      dataSource: ScheduleDataSource(schedules),
      viewHeaderHeight: 0,
      headerStyle: const CalendarHeaderStyle(textAlign: TextAlign.center),
      headerDateFormat: 'yMMMMEEEEd',
      minDate: getTime(0, 0),
      maxDate: getTime(23, 59),
      initialDisplayDate: showDisplayDate(),
      appointmentTextStyle: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto',
      ),
      onLongPress: (calendarLongPressDetails) => showCalendarDetail(
          context, scheduleNotifier, calendarLongPressDetails),
    );
  }

  /// currentTimeIndicator를 가운데로 두는 함수
  DateTime showDisplayDate() {
    final today = DateTime.now();
    int hour = today.hour;
    int minute = today.minute;
    if (today.hour < 5) {
      hour = 0;
      minute = 0;
    } else if (today.hour < 20) {
      hour -= 5;
    }
    return getTime(hour, minute);
  }

  void showCalendarDetail(
      BuildContext context,
      ScheduleNotifier scheduleNotifier,
      CalendarLongPressDetails calendarLongPressDetails) {
    const title = Text('Warning');
    const content = Text('Are you sure you want to delete this schedule?');
    final actions = [
      TextButton(
        onPressed: () => Navigator.pop(context, 'Cancel'),
        child: Text(
          'Cancel',
          style: TextStyle(color: button_color),
        ),
      ),
      TextButton(
        onPressed: () {
          scheduleNotifier
              .delete(calendarLongPressDetails.appointments![0] as Schedule);
          Navigator.pop(context, 'OK');
        },
        child: Text('OK', style: TextStyle(color: button_color)),
      ),
    ];
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: title,
          content: content,
          actions: actions,
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: title,
          content: content,
          actions: actions,
        ),
      );
    }
  }
}
