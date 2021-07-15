import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 1)
class Note {
  @HiveField(0)
  String? id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String body;
  @HiveField(3)
  DateTime? createdAt;

  Note({
    this.id,
    required this.title,
    required this.body,
    this.createdAt,
  });
}
