import 'package:flutter/material.dart';
import 'package:haru/common/my_app_bar.dart';
import 'package:haru/main.dart';
import 'package:haru/timer/timer_background.dart';

class TimerPage extends StatelessWidget {
  static const routeName = '/timer';
  const TimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Stack(
        children: [
          TimerBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 100,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
