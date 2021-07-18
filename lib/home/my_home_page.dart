import 'package:flutter/material.dart';
import 'package:haru/common/const_values.dart';

import 'package:haru/common/widgets/my_drawer.dart';
import 'package:haru/home/widgets/analog_clock.dart';
import 'package:haru/home/widgets/today_list_view.dart';
import 'package:intl/intl.dart';

import 'widgets/today_add_modal.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = '/';
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadiusCircular),
              ),
              builder: (context) => SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: TodayAddModal(),
              ),
            ),
            icon: const Icon(Icons.add),
            splashRadius: Material.defaultSplashRadius / 2,
          )
        ],
        elevation: 0,
      ),
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
