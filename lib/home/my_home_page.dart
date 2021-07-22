import 'package:flutter/material.dart';
import 'package:haru/common/const_values.dart';

import 'package:haru/common/widgets/my_drawer.dart';
import 'package:haru/home/clocks/neumorphic/neumorphic_clock.dart';
import 'package:haru/home/widgets/today_list_view.dart';
import 'package:haru/models/schedule/schedule.dart';
import 'package:hive/hive.dart';

import 'clocks/plain/analog_clock.dart';
import 'widgets/today_add_modal.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = '/';

  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Box<Schedule> storeData;

  @override
  void initState() {
    super.initState();
    storeData = Hive.box(scheduleBox);
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage(todayAddModalBackgrounImage), context);
    final List<Schedule> schedules =
        storeData.keys.cast<int>().map((key) => storeData.get(key)!).toList();
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
            // SizedBox(
            //   height: 300,
            //   child: AnalogClock(),
            // ),
            NeumorphicClock(),
            Expanded(
              child: TodayListView(schedules: schedules),
            ),
          ],
        ),
      ),
    );
  }
}
