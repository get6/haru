library globals;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:haru/models/schedule/schedule.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();
const String noteBox = 'noteBox';
const String scheduleBox = 'scheduleBox';
const double borderRadiusCircular = 30.0;
const String todayAddModalBackgrounImage = 'assets/images/landscape.jpeg';
const String noteEditModalBackgrounImage = 'assets/images/yosemite.png';

String padLeftForTime(int number) {
  return number.toString().padLeft(2, '0');
}

DateTime getTime(int hour, int minute) {
  final today = DateTime.now();
  return DateTime(today.year, today.month, today.day, hour, minute);
}

Color randomColor() {
  final _random = Random();
  return Colors.primaries[_random.nextInt(Colors.primaries.length)];
}

void setInitialData(Box<Schedule> storeData) {
  if (storeData.isNotEmpty) storeData.clear();

  List<String> titles = [
    '스터디 참여',
    '수업 듣기',
    '줌 강의 듣기',
    '성수역 가기',
    '프로젝트 진행',
    '친구와 약속',
    '독서하기',
    '등산가기'
  ];
  List<DateTime> starts = [
    DateTime(2021, 07, 29, 9),
    DateTime(2021, 07, 29, 14),
    DateTime(2021, 07, 28, 14),
    DateTime(2021, 07, 27, 20, 30),
    DateTime(2021, 07, 26, 09),
    DateTime(2021, 07, 25, 18, 30),
    DateTime(2021, 07, 24, 15),
    DateTime(2021, 07, 23, 09),
  ];
  List<DateTime> ends = [
    DateTime(2021, 07, 29, 10),
    DateTime(2021, 07, 29, 16),
    DateTime(2021, 07, 28, 17, 30),
    DateTime(2021, 07, 27, 21),
    DateTime(2021, 07, 26, 18),
    DateTime(2021, 07, 25, 21),
    DateTime(2021, 07, 24, 18),
    DateTime(2021, 07, 23, 18),
  ];
  List<Schedule> values = [];
  for (var i = 0; i < titles.length; i++) {
    values.add(Schedule(
      title: titles[i],
      color: randomColor().value,
      startTime: starts[i],
      endTime: ends[i],
      createdAt: DateTime.now(),
    ));
  }

  storeData.addAll(values);
}
