import 'package:flutter/material.dart';
import 'package:haru/home/widgets/today_time_field.dart';

class TodayAddModal extends StatefulWidget {
  TodayAddModal({Key? key}) : super(key: key);

  @override
  _TodayAddModalState createState() => _TodayAddModalState();
}

class _TodayAddModalState extends State<TodayAddModal> {
  final _formKey = GlobalKey<FormState>();
  final TimeOfDay _startTime = TimeOfDay.now().replacing(minute: 30);
  final TimeOfDay _endTime = TimeOfDay.now().replacing(minute: 30);

  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  final TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  Text('Make a new schedule!'),
                ],
              ),
            ),
            TextFormField(
              // autofocus: true,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "Title",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TodayTimeField(
                    value: _startTime,
                    labelText: 'Start Date',
                    validateText: 'Please enter start time',
                  ),
                ),
                const SizedBox(width: 30, child: Text('~')),
                Expanded(
                  child: TodayTimeField(
                    value: _endTime,
                    labelText: 'End Date',
                    validateText: 'Please enter end time',
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: TextButton.styleFrom(
                        primary: Colors.black87,
                        elevation: 0,
                      ),
                      child: const Text('Cancel'),
                      // style: ElevatedButton.styleFrom(primary: Colors.grey[300]),
                    ),
                    const SizedBox(width: 30),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Saved event!')),
                          );
                        }
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.black87,
                        elevation: 0,
                      ),
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
