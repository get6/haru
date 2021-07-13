// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) {
  return Schedule(
    id: json['id'] as int,
    title: json['title'] as String,
    startTime: json['startTime'] as String,
    endTime: json['endTime'] as String,
  );
}

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };
