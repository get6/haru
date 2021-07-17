import 'package:flutter/material.dart';
import 'package:haru/common/const_values.dart';
import 'package:haru/models/note/note.dart';
import 'package:hive/hive.dart';

class NotesEditModal extends StatefulWidget {
  static const routeName = '/noteAdd';

  int? noteKey;
  NotesEditModal({Key? key, this.noteKey}) : super(key: key);

  @override
  _NotesEditModalState createState() => _NotesEditModalState();
}

class _NotesEditModalState extends State<NotesEditModal> {
  late Box<Note> storeData;
  final TextEditingController _noteTitle = TextEditingController();
  final TextEditingController _noteBody = TextEditingController();

  @override
  void initState() {
    super.initState();
    storeData = Hive.box(noteBox);
  }

  @override
  void dispose() {
    super.dispose();
    _noteTitle.dispose();
    _noteBody.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.noteKey != null) {
      final Note note = storeData.get(widget.noteKey)!;
      _noteTitle.text = note.title;
      _noteBody.text = note.body;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(children: [const Text('Title')]),
          const SizedBox(height: 10),
          TextField(
            controller: _noteTitle,
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Row(children: [Text('Text')]),
          const SizedBox(height: 10),
          TextField(
            controller: _noteBody,
            textCapitalization: TextCapitalization.sentences,
            maxLines: 10,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
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
              ElevatedButton(
                onPressed: () => saveNote(),
                style: TextButton.styleFrom(
                  primary: Colors.black87,
                  elevation: 0,
                ),
                child: const Text('Submit'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void saveNote() {
    final String title = _noteTitle.text;
    final String body = _noteBody.text;
    if (widget.noteKey != null) {
      final addedNote = storeData.get(widget.noteKey)!;
      final note =
          Note(title: title, body: body, createdAt: addedNote.createdAt);
      storeData.putAt(widget.noteKey!, note);
    } else {
      final Note note =
          Note(title: title, body: body, createdAt: DateTime.now());
      storeData.add(note);
    }

    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Saved note!')),
    );
  }
}
