import 'package:flutter/material.dart';
import 'package:haru/histories/histories_page.dart';
import 'package:haru/routes/routes.dart';
import 'package:haru/settings/settings_page.dart';
import 'package:haru/timer/timer_page.dart';
import 'package:logger/logger.dart';

import 'common/color/custom_color.dart';
import 'home/my_home_page.dart';

void main() {
  runApp(MyApp());
}

Logger logger = Logger();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haru',
      theme: ThemeData(primarySwatch: createPrimaryColor(main_color)),
      initialRoute: MyHomePage.routeName,
      routes: {
        Routes.home: (context) => MyHomePage(),
        Routes.histories: (context) => HistoriesPage(),
        Routes.timer: (context) => TimerPage(),
        Routes.settings: (context) => SettingsPage(),
      },
    );
  }
}
