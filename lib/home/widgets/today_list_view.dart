import 'package:flutter/material.dart';
import 'package:haru/common/const_values.dart';
import 'package:haru/models/schedule/schedule.dart';
import 'package:haru/models/schedule/schedule_data_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TodayListView extends ConsumerWidget {
  TodayListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final schedules = watch(scheduleRepositoryProvider).fetchTodaySchedules();
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
}
