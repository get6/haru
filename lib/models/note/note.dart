import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 1)
class Note {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String body;
  @HiveField(2)
  DateTime? createdAt;

  Note({
    required this.title,
    required this.body,
    this.createdAt,
  });
}
