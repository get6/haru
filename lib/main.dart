import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:haru/common/const_values.dart';
import 'package:haru/histories/histories_page.dart';
import 'package:haru/models/schedule/schedule.dart';
import 'package:haru/notes/notes_edit_modal.dart';
import 'package:haru/notes/notes_page.dart';
import 'package:haru/routes/routes.dart';
import 'package:haru/settings/settings_page.dart';
import 'package:haru/timer/timer_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/subjects.dart';
import 'common/color/custom_color.dart';
import 'home/my_home_page.dart';
import 'models/note/note.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();
final selectNotificationSubject = BehaviorSubject<String?>();

const platform = MethodChannel('com.ittae.haru');

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

void main() async {
  // final NotificationAppLaunchDetails? notificationAppLaunchDetails =
  //     await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  // if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
  //   selectedNotificationPayload = notificationAppLaunchDetails!.payload;
  // }

  // const AndroidInitializationSettings initializationSettingsAndroid =
  //     AndroidInitializationSettings('app_icon');

  // /// Note: permissions aren't requested here just to demonstrate that can be
  // /// done later
  // final IOSInitializationSettings initializationSettingsIOS =
  //     IOSInitializationSettings(
  //         requestAlertPermission: false,
  //         requestBadgePermission: false,
  //         requestSoundPermission: false,
  //         onDidReceiveLocalNotification:
  //             (int id, String? title, String? body, String? payload) async {
  //           didReceiveLocalNotificationSubject.add(ReceivedNotification(
  //               id: id, title: title, body: body, payload: payload));
  //         });
  // const MacOSInitializationSettings initializationSettingsMacOS =
  //     MacOSInitializationSettings(
  //         requestAlertPermission: false,
  //         requestBadgePermission: false,
  //         requestSoundPermission: false);
  // final InitializationSettings initializationSettings = InitializationSettings(
  //     android: initializationSettingsAndroid,
  //     iOS: initializationSettingsIOS,
  //     macOS: initializationSettingsMacOS);
  // await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //     onSelectNotification: (String? payload) async {
  //   if (payload != null) {
  //     debugPrint('notification payload: $payload');
  //   }
  //   selectedNotificationPayload = payload;
  //   selectNotificationSubject.add(payload);
  // });

  await Hive.initFlutter();
  Hive.registerAdapter(ScheduleAdapter());
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Schedule>(scheduleBox);
  await Hive.openBox<Note>(noteBox);

  runApp(ProviderScope(child: MyApp()));
}

String? selectedNotificationPayload;

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
        Routes.notesEdit: (context) => NotesEditModal(),
      },
    );
  }
}
