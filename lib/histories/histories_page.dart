import 'package:flutter/material.dart';
import 'package:haru/common/my_app_bar.dart';
import 'package:haru/common/my_drawer.dart';

class HistoriesPage extends StatelessWidget {
  static const routeName = '/histories';
  const HistoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(),
    );
  }
}
