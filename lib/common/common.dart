// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// // 데이터베이스를 열고 참조 값을 얻습니다.
// final Future<Database> database = getDatabasesPath().then(
//   (path) => openDatabase(
//     join(path, 'schedule_database.db'),
//     onCreate: (db, version) => db.execute(
//       'CREATE TABLE schedules(id INTEGER PRIMARY KEY, title TEXT, start_time TEXT, end_time TEXT)',
//     ),
//     version: 1,
//   ),
// );
