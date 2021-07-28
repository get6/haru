import 'package:flutter/material.dart';
import 'package:haru/common/const_values.dart';
import 'package:haru/models/note/note.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NoteNotifier extends ChangeNotifier {
  final Box<Note> storeData;

  NoteNotifier({required this.storeData});

  void add(Note note) async {
    await storeData.add(note);
    notifyListeners();
  }

  void delete(int key) async {
    await storeData.delete(key);
    notifyListeners();
  }

  void update(int noteKey, Note note) async {
    int i = 0;
    for (final key in storeData.keys.cast<int>()) {
      if (key == noteKey) {
        break;
      }
      i++;
    }
    await storeData.putAt(i, note);
    notifyListeners();
  }
}

final noteBoxProvider = StateProvider<Box<Note>>((ref) => Hive.box(noteBox));

final noteProvider = ChangeNotifierProvider<NoteNotifier>(
    (ref) => NoteNotifier(storeData: ref.watch(noteBoxProvider).state));
