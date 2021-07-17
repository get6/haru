import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:haru/common/color/custom_color.dart';
import 'package:haru/common/const_values.dart';
import 'package:haru/models/note/note.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'notes_edit_modal.dart';

class NotesPage extends StatelessWidget {
  static const routeName = '/notes';
  Box<Note> storeData = Hive.box<Note>(noteBox);
  NotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              // TODO 키보드 입력시 위로 올라가기때문에 페이지로 전환 고민
              showModalBottomSheet(
                context: context,
                builder: (context) => NotesEditModal(),
                isScrollControlled: true,
              );
            },
            icon: const Icon(Icons.add),
            splashRadius: Material.defaultSplashRadius / 2,
          )
        ],
        elevation: 0,
      ),
      body: ValueListenableBuilder(
        valueListenable: storeData.listenable(),
        builder: (context, Box<Note> notes, child) {
          final List<int> keys =
              notes.keys.cast<int>().toList().reversed.toList();
          return storeData.isEmpty
              ? const Center(
                  child: Text(
                    'No Notes yet...😔',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: StaggeredGridView.countBuilder(
                      physics: const NeverScrollableScrollPhysics(),
                      primary: false,
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      itemCount: keys.length,
                      itemBuilder: (_, index) {
                        final key = keys[index];
                        final Note? note = notes.get(key);
                        return GestureDetector(
                          onTap: () {},
                          onLongPress: () {},
                          child: Container(
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
                                      top: 16.0, left: 16.0, right: 16.0),
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
                                  child: Text(
                                    note.body,
                                    softWrap: true,
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: IconButton(
                                        onPressed: () => showModalBottomSheet(
                                          context: context,
                                          builder: (context) =>
                                              NotesEditModal(noteKey: key),
                                          isScrollControlled: true,
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
                                          deleteDialog(context, key);
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
                          ),
                        );
                      },
                      staggeredTileBuilder: (index) {
                        final key = keys[index];
                        final Note? note = notes.get(key);
                        final int bodyLength = note!.body.length;
                        final double mainAxisCellCount = (bodyLength < 10
                                ? 1
                                : int.parse(bodyLength.toString()[0])) +
                            .4;
                        return StaggeredTile.count(2, mainAxisCellCount);
                      },
                    ),
                  ),
                );
        },
      ),
    );
  }

  void deleteDialog(BuildContext context, int key) {
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
          storeData.delete(key);
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
