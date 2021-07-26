import 'package:flutter/material.dart';
import 'package:haru/common/const_values.dart';
import 'package:haru/models/note/note_notifier.dart';
import 'package:haru/notes/widgets/notes_edit_form.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotesEditPage extends ConsumerWidget {
  static const routeName = '/notesEdit';
  final int? noteKey;
  const NotesEditPage({Key? key, this.noteKey}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final noteNotifier = watch(noteProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadiusCircular),
          topRight: Radius.circular(borderRadiusCircular),
        ),
        image: DecorationImage(
          image: AssetImage(noteEditModalBackgrounImage),
          fit: BoxFit.cover,
          alignment: Alignment(0.4, 0),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadiusCircular),
              ),
            ),
            child: NotesEditForm(noteNotifier: noteNotifier, noteKey: noteKey),
          ),
        ],
      ),
    );
  }
}
