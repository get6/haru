library globals;

import 'package:logger/logger.dart';

final Logger logger = Logger();
const String noteBox = 'noteBox';
const String scheduleBox = 'scheduleBox';
const double borderRadiusCircular = 30.0;

String padLeftForTime(int number) {
  return number.toString().padLeft(2, '0');
}

DateTime getTime(int hour, int minute) {
  final today = DateTime.now();
  return DateTime(today.year, today.month, today.day, hour, minute);
}
