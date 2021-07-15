import 'package:flutter/material.dart';
import 'package:haru/common/const_values.dart';
import 'package:haru/models/note/note.dart';
import 'package:hive/hive.dart';

class NotesAddModal extends StatefulWidget {
  static const routeName = '/noteAdd';
  const NotesAddModal({Key? key}) : super(key: key);

  @override
  _NotesAddModalState createState() => _NotesAddModalState();
}

class _NotesAddModalState extends State<NotesAddModal> {
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        children: [
          Row(children: [Text('Title')]),
          SizedBox(height: 10),
          TextField(
            controller: _noteTitle,
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          Row(children: [Text('Text')]),
          SizedBox(height: 10),
          TextField(
            controller: _noteBody,
            textCapitalization: TextCapitalization.sentences,
            maxLines: 10,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          Expanded(
            child: Row(
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
          ),
        ],
      ),
    );
  }

  void saveNote() {
    final String title = _noteTitle.text;
    final String body = _noteBody.text;
    final Note note = Note(title: title, body: body, createdAt: DateTime.now());
    storeData.add(note);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Saved note!')),
    );
  }
}
