import 'package:flutter/material.dart';
import 'package:haru/common/const_values.dart';
import 'package:haru/models/note/note.dart';
import 'package:hive/hive.dart';

class NotesEditModal extends StatefulWidget {
  static const routeName = '/notesEdit';
  int? noteKey;

  NotesEditModal({Key? key, this.noteKey}) : super(key: key);

  @override
  _NotesEditModalState createState() => _NotesEditModalState();
}

class _NotesEditModalState extends State<NotesEditModal> {
  final _formKey = GlobalKey<FormState>();
  late Box<Note> storeData;
  late TextEditingController titleController;
  late TextEditingController contentsController;

  @override
  void initState() {
    super.initState();
    storeData = Hive.box(noteBox);

    titleController = TextEditingController();
    contentsController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.noteKey != null) {
      final Note note = storeData.get(widget.noteKey)!;
      titleController.text = note.title;
      contentsController.text = note.contents;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadiusCircular),
          topRight: Radius.circular(borderRadiusCircular),
        ),
        image: DecorationImage(
          image: AssetImage('assets/images/yosemite.png'),
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
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadiusCircular)),
            ),
            child: Form(
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
            ),
          ),
        ],
      ),
    );
  }

  void saveNote() async {
    if (_formKey.currentState!.validate()) {
      final title = titleController.text;
      final body = contentsController.text;

      if (widget.noteKey != null) {
        // Update
        final editedNote = storeData.get(widget.noteKey)!;
        await storeData.putAt(
            widget.noteKey!,
            Note(
              title: title,
              contents: body,
              createdAt: editedNote.createdAt,
            ));
      } else {
        // Save
        await storeData.add(Note(
          title: title,
          contents: body,
          createdAt: DateTime.now(),
        ));
      }

      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saved a note!')),
      );
    }
  }
}
