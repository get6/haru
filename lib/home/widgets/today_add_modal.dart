import 'package:flutter/material.dart';
import 'package:haru/common/const_values.dart';
import 'package:haru/home/widgets/today_time_field.dart';
import 'package:haru/models/schedule/schedule.dart';
import 'package:hive/hive.dart';

class TodayAddModal extends StatefulWidget {
  TodayAddModal({Key? key}) : super(key: key);

  @override
  _TodayAddModalState createState() => _TodayAddModalState();
}

class _TodayAddModalState extends State<TodayAddModal> {
  final _formKey = GlobalKey<FormState>();
  late Box<Schedule> storeData;

  late TextEditingController titleController;
  late TextEditingController startController;
  late TextEditingController endController;

  late DateTime _startTime;
  late DateTime _endTime;

  @override
  void initState() {
    super.initState();
    storeData = Hive.box(scheduleBox);

    titleController = TextEditingController();
    startController = TextEditingController();
    endController = TextEditingController();

    final today = DateTime.now();
    _startTime = getTime(today.hour, 30);
    _endTime = getTime(today.hour, 30);
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
          image: AssetImage('assets/images/landscape.jpeg'),
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
                    decoration: const InputDecoration(
                      labelText: "Title",
                      border: OutlineInputBorder(),
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
                      ElevatedButton(
                        onPressed: () => saveSchedule(),
                        style: TextButton.styleFrom(
                          primary: Colors.black87,
                          elevation: 0,
                        ),
                        child: const Text('Submit'),
                      ),
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

  void saveSchedule() async {
    if (_formKey.currentState!.validate()) {
      final startText = startController.text;
      final endText = endController.text;

      await storeData.add(Schedule(
        title: titleController.text,
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
