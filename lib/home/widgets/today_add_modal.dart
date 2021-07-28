import 'dart:math';

import 'package:flutter/material.dart';
import 'package:haru/common/const_values.dart';
import 'package:haru/home/widgets/today_time_field.dart';
import 'package:haru/models/schedule/schedule.dart';
import 'package:haru/models/schedule/schedule_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TodayAddModal extends StatefulWidget {
  const TodayAddModal({Key? key}) : super(key: key);

  @override
  _TodayAddModalState createState() => _TodayAddModalState();
}

class _TodayAddModalState extends State<TodayAddModal> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController titleController;
  late TextEditingController startController;
  late TextEditingController endController;

  late DateTime _startTime;
  late DateTime _endTime;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController();
    startController = TextEditingController();
    endController = TextEditingController();

    final today = DateTime.now();
    _startTime = getTime(today.hour, 0);
    _endTime = getTime(23 <= today.hour ? today.hour : today.hour + 1, 0);
  }

  @override
  void dispose() {
    titleController.dispose();
    startController.dispose();
    endController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadiusCircular),
          topRight: Radius.circular(borderRadiusCircular),
        ),
        image: DecorationImage(
          image: AssetImage(todayAddModalBackgrounImage),
          fit: BoxFit.cover,
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text('Make a new schedule!',
                        style: Theme.of(context).textTheme.overline),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: titleController,
                    maxLength: 20,
                    decoration: InputDecoration(
                      labelText: "Title",
                      suffixIcon: titleController.text.isNotEmpty
                          ? IconButton(
                              onPressed: () => titleController.clear(),
                              icon: const Icon(Icons.clear))
                          : null,
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TodayTimeField(
                    time: _startTime,
                    timeController: startController,
                    otherTimeController: endController,
                    labelText: 'Start Time',
                  ),
                  const SizedBox(height: 20),
                  TodayTimeField(
                    time: _endTime,
                    timeController: endController,
                    otherTimeController: startController,
                    labelText: 'End Time',
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: TextButton.styleFrom(
                          primary: Colors.black87,
                          elevation: 0,
                        ),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 20),
                      Consumer(builder: (context, watch, _) {
                        final scheduleNotifier = watch(scheduleProvider);
                        return ElevatedButton(
                          onPressed: () => saveSchedule(scheduleNotifier),
                          style: TextButton.styleFrom(
                            primary: Colors.black87,
                            elevation: 0,
                          ),
                          child: const Text('Submit'),
                        );
                      }),
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

  void saveSchedule(ScheduleNotifier scheduleNotifier) {
    if (_formKey.currentState!.validate()) {
      final startText = startController.text;
      final endText = endController.text;
      final _random = Random();
      final color = Colors.primaries[_random.nextInt(Colors.primaries.length)];

      scheduleNotifier.add(Schedule(
        title: titleController.text,
        color: color.value,
        startTime: getTime(int.parse(startText.split(":")[0]),
            int.parse(startText.split(":")[1])),
        endTime: getTime(
            int.parse(endText.split(":")[0]), int.parse(endText.split(":")[1])),
        createdAt: DateTime.now(),
      ));

      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saved a schedule!')),
      );
    }
  }
}
