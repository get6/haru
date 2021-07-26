import 'package:flutter/material.dart';
import 'package:haru/models/note/note.dart';
import 'package:haru/models/note/note_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotesEditForm extends StatefulWidget {
  final NoteNotifier noteNotifier;
  final int? noteKey;

  const NotesEditForm({Key? key, required this.noteNotifier, this.noteKey})
      : super(key: key);

  @override
  _NotesEditFormState createState() => _NotesEditFormState();
}

class _NotesEditFormState extends State<NotesEditForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController contentsController;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController();
    contentsController = TextEditingController();

    if (widget.noteKey != null) {
      final Note note = widget.noteNotifier.storeData.get(widget.noteKey)!;
      titleController.text = note.title;
      contentsController.text = note.contents;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text('Make a new note!',
                style: Theme.of(context).textTheme.overline),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: contentsController,
            textCapitalization: TextCapitalization.sentences,
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: 'Contents',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter contents';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  primary: Colors.black87,
                  elevation: 0,
                ),
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 30),
              Consumer(
                builder: (context, watch, child) => ElevatedButton(
                  onPressed: () => saveNote(watch(noteProvider)),
                  style: TextButton.styleFrom(
                    primary: Colors.black87,
                    elevation: 0,
                  ),
                  child: const Text('Submit'),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void saveNote(NoteNotifier noteNotifier) async {
    if (_formKey.currentState!.validate()) {
      final title = titleController.text;
      final body = contentsController.text;

      if (widget.noteKey != null) {
        // Update
        final note = widget.noteNotifier.storeData.get(widget.noteKey)!;
        noteNotifier.update(widget.noteKey!, note);
      } else {
        // Save
        final note =
            Note(title: title, contents: body, createdAt: DateTime.now());
        noteNotifier.add(note);
      }

      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saved a note!')),
      );
    }
  }
}
