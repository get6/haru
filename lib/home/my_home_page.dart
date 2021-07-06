import 'package:flutter/material.dart';
import 'package:haru/common/my_app_bar.dart';
import 'package:haru/common/my_drawer.dart';
import 'package:haru/home/widgets/today_list_view.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = '/';
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(),
      drawer: const MyDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Text('Clock is Here'),
            Expanded(
              child: TodayListView(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
