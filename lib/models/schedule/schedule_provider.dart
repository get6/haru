// import 'dart:ui';

// import 'package:haru/model/schedule.dart';
// import 'package:sqflite/sqflite.dart';

// class ScheduleProvider {
//   final tableSchedule = 'schedules';
//   final String columnId = 'id';
//   final String columnTitle = 'title';
//   final String columnStartTime = 'startTime';
//   final String columnEndTime = 'endTime';

//   late Database db;

//   Future open(String path) async {
//     db = await openDatabase(path, version: 1, onCreate: (db, version) async {
//       await db.execute('''
//         CREATE TABLE $tableSchedule (
//           id INTEGER PRIMARY KEY AUTOINCREMENT,
//           title TEXT NOT NULL,
//           start_time TEXT NOT NULL,
//           end_time TEXT NOT NULL,
//         )
//       ''');
//     });
//   }

//   Future<Schedule> insert(Schedule schedule) async {
//     schedule.id = await db.insert(tableSchedule, schedule.toJson());
//     return schedule;
//   }

//   Future<Schedule?> getSchedule(int id) async {
//     final List<Map<String, dynamic>> maps = await db.query(
//       tableSchedule,
//       columns: [columnId, columnTitle, columnStartTime, columnEndTime],
//       where: '$columnId = ?',
//       whereArgs: [id],
//     );
//     if (maps.isNotEmpty) {
//       return Schedule.fromJson(maps.first);
//     }
//     return null;
//   }

//   Future<int> delete(int id) async {
//     return db.delete(tableSchedule, where: '$columnId = ?', whereArgs: [id]);
//   }

//   Future<int> update(Schedule schedule) async {
//     return db.update(tableSchedule, schedule.toJson(),
//         where: '$columnId = ?', whereArgs: [schedule.id]);
//   }

//   Future close() async => db.close();
// }
