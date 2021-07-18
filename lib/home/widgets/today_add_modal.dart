import 'package:flutter/material.dart';
import 'package:haru/common/const_values.dart';
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
  final TimeOfDay selectedTime = TimeOfDay.now();

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
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
            // constraints: const BoxConstraints(maxHeight: 400),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text('Make a new schedule!',
                        style: Theme.of(context).textTheme.overline),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
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
                  const SizedBox(height: 30),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
