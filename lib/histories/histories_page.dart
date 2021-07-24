import 'package:flutter/material.dart';
import 'package:haru/common/color/custom_color.dart';
import 'package:haru/common/const_values.dart';
import 'package:haru/common/empty_page.dart';
import 'package:haru/models/schedule/schedule.dart';
import 'package:haru/models/schedule/schedule_data_source.dart';
import 'package:hive/hive.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HistoriesPage extends StatefulWidget {
  static const routeName = '/histories';
  const HistoriesPage({Key? key}) : super(key: key);

  @override
  _HistoriesPageState createState() => _HistoriesPageState();
}

class _HistoriesPageState extends State<HistoriesPage> {
  late Box<Schedule> storeData;

  @override
  void initState() {
    storeData = Hive.box(scheduleBox);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Schedule> schedules =
        storeData.keys.cast<int>().map((key) => storeData.get(key)!).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: storeData.isEmpty ? empty_color : Colors.white,
          elevation: 0),
      body: storeData.isEmpty
          ? const EmptyPage(
              title: 'No schedules here! 😥',
              subtitle: 'Create a schedule from the home screen! 🤩',
            )
          : SfCalendar(
              view: CalendarView.week,
              maxDate: getTime(23, 59),
              firstDayOfWeek: (DateTime.now().weekday % 7) + 1,
              headerStyle: const CalendarHeaderStyle(
                textAlign: TextAlign.center,
              ),
              dataSource: ScheduleDataSource(schedules),
            ),
    );
  }
}
