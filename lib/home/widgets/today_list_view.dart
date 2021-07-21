import 'package:flutter/material.dart';
import 'package:haru/common/color/custom_color.dart';
import 'package:haru/common/const_values.dart';
import 'package:haru/main.dart';
import 'package:haru/models/schedule/schedule.dart';
import 'package:haru/models/schedule/schedule_data_source.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TodayListView extends StatelessWidget {
  final List<Schedule> schedules;

  TodayListView({Key? key, required this.schedules}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      dataSource: ScheduleDataSource(schedules),
      viewHeaderHeight: 0,
      headerStyle: const CalendarHeaderStyle(textAlign: TextAlign.center),
      headerDateFormat: 'yMMMMEEEEd',
      minDate: getTime(0, 0),
      maxDate: getTime(23, 59),
    );
  }
}
