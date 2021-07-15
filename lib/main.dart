import 'package:flutter/material.dart';
import 'package:haru/common/const_values.dart';
import 'package:haru/histories/histories_page.dart';
import 'package:haru/models/schedule/schedule.dart';
import 'package:haru/notes/notes_add_modal.dart';
import 'package:haru/notes/notes_page.dart';
import 'package:haru/routes/routes.dart';
import 'package:haru/settings/settings_page.dart';
import 'package:haru/timer/timer_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'common/color/custom_color.dart';
import 'home/my_home_page.dart';
import 'models/note/note.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ScheduleAdapter());
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Schedule>(scheduleBox);
  await Hive.openBox<Note>(noteBox);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haru',
      theme: ThemeData(
        primarySwatch: createPrimaryColor(main_color),
        // accentColor: createAccentColor(accent_color),
      ),
      initialRoute: MyHomePage.routeName,
      routes: {
        Routes.home: (context) => MyHomePage(),
        Routes.histories: (context) => HistoriesPage(),
        Routes.timer: (context) => TimerPage(),
        Routes.settings: (context) => SettingsPage(),
        Routes.notes: (context) => NotesPage(),
        Routes.notesAdd: (context) => NotesAddModal(),
      },
    );
  }
}
