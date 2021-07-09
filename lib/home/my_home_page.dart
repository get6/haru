import 'package:flutter/material.dart';
import 'package:haru/common/color/custom_color.dart';
import 'package:haru/common/my_app_bar.dart';
import 'package:haru/common/my_drawer.dart';
import 'package:haru/home/widgets/analog_clock.dart';
import 'package:haru/home/widgets/today_list_view.dart';
import 'package:intl/intl.dart';

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
      appBar: MyAppBar(isHome: true),
      drawer: const MyDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            // 날짜 앞에 이모지 30개 해서 매일 바꾸게끔 폰트도 정하기
            Text(
              DateFormat('yyyy.MM.dd').format(DateTime.now()).toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 10),
            Flexible(child: AnalogClock()),
            Expanded(
              child: TodayListView(),
            ),
          ],
        ),
      ),
    );
  }
}
