import 'package:flutter/material.dart';
import 'package:haru/histories/histories_page.dart';
import 'package:haru/notes/notes_add_page.dart';
import 'package:haru/notes/notes_page.dart';
import 'package:haru/routes/routes.dart';
import 'package:haru/settings/settings_page.dart';
import 'package:haru/timer/timer_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


import 'package:logger/logger.dart';

import 'common/color/custom_color.dart';
import 'home/my_home_page.dart';

void main() async {
  await Hive.initFlutter();
  runApp(MyApp());
}

Logger logger = Logger();

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
        Routes.notesAdd: (context) => NotesAddPage(),
      },
    );
  }
}
