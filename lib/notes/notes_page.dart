import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:haru/common/color/custom_color.dart';
import 'package:haru/common/const_values.dart';
import 'package:haru/common/empty_page.dart';
import 'package:haru/models/note/note.dart';
import 'package:haru/models/note/note_notifier.dart';
import 'package:haru/notes/notes_edit_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../common/const_values.dart';

class NotesPage extends ConsumerWidget {
  static const routeName = '/notes';
  const NotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    precacheImage(const AssetImage(noteEditModalBackgrounImage), context);
    final noteNotifier = watch(noteProvider.notifier);
    final storeData = noteNotifier.storeData;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: empty_color,
      appBar: AppBar(
        backgroundColor: empty_color,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => openDialog(context, noteNotifier),
            icon: const Icon(Icons.add),
            splashRadius: Material.defaultSplashRadius / 2,
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: storeData.listenable(),
        builder: (context, Box<Note> notes, child) {
          final List<int> keys =
              notes.keys.cast<int>().toList().reversed.toList();
          return storeData.isEmpty
              ? const EmptyPage(
                  title: 'No notes here! 😥',
                  subtitle: 'Try to click the add button on top! 😆',
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: StaggeredGridView.countBuilder(
                      physics: const NeverScrollableScrollPhysics(),
                      primary: false,
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      itemCount: keys.length,
                      itemBuilder: (_, index) {
                        final key = keys[index];
                        final Note? note = notes.get(key);
                        return Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 12.0, left: 8.0, right: 8.0),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFA5FBFF),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  child: Text(
                                    note!.title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(note.contents, softWrap: true),
                              ),
                              Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: IconButton(
                                      onPressed: () => openDialog(
                                        context,
                                        noteNotifier,
                                        noteKey: key,
                                      ),
                                      icon: const Icon(
                                        Icons.edit,
                                        size: 18,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: IconButton(
                                      onPressed: () {
                                        deleteDialog(
                                            context, key, noteNotifier);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        size: 18,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      staggeredTileBuilder: (index) {
                        return const StaggeredTile.fit(1);
                      },
                    ),
                  ),
                );
        },
      ),
    );
  }

  void openDialog(BuildContext context, NoteNotifier noteNotifier,
      {int? noteKey}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusCircular),
      ),
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: noteKey == null
            ? const NotesEditPage()
            : NotesEditPage(noteKey: noteKey),
      ),
    );
  }

  void deleteDialog(BuildContext context, int key, NoteNotifier noteNotifier) {
    const title = Text('Warning');
    const content = Text('Are you sure you want to delete this note?');
    final actions = [
      TextButton(
        onPressed: () => Navigator.pop(context, 'Cancel'),
        child: Text(
          'Cancel',
          style: TextStyle(color: button_color),
        ),
      ),
      TextButton(
        onPressed: () {
          noteNotifier.delete(key);
          Navigator.pop(context, 'OK');
        },
        child: Text('OK', style: TextStyle(color: button_color)),
      ),
    ];
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: title,
          content: content,
          actions: actions,
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: title,
          content: content,
          actions: actions,
        ),
      );
    }
  }
}
