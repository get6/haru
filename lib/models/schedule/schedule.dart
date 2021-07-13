import 'package:json_annotation/json_annotation.dart';
part 'schedule.g.dart';

@JsonSerializable()
class Schedule {
  int id;
  final String title;
  // @JsonKey(name: 'start_time')
  final String startTime;
  final String endTime;

  Schedule({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}
