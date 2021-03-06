import 'package:flutter/material.dart';
import 'package:haru/common/color/custom_color.dart';
import 'package:haru/common/const_values.dart';
import 'package:haru/common/widgets/my_drawer.dart';
import 'package:haru/home/clocks/neumorphic/neumorphic_clock.dart';
import 'package:haru/home/widgets/today_list_view.dart';
import 'package:haru/models/schedule/schedule.dart';
import 'package:hive/hive.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: neumorphicTheme[neumorphicColor.background],
      appBar: AppBar(
        backgroundColor: neumorphicTheme[neumorphicColor.background],
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
                child: const TodayAddModal(),
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
          children: const [
            NeumorphicClock(),
            Expanded(child: TodayListView()),
          ],
        ),
      ),
    );
  }
}
