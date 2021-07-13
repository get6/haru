import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodayTimeField extends StatelessWidget {
  TextEditingController timeController = TextEditingController();
  TimeOfDay value;
  String labelText;
  String validateText;

  TodayTimeField({
    Key? key,
    required this.value,
    required this.labelText,
    required this.validateText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      controller: timeController,
      decoration: InputDecoration(labelText: labelText),
      format: DateFormat("HH:mm"),
      onShowPicker: (context, currentValue) async {
        Navigator.of(context).push(
          showPicker(
            context: context,
            value: value,
            onChange: onTimeChanged,
          ),
        );
        return Future.value(null);
      },
      validator: (value) {
        if (value == null) {
          return validateText;
        }
        return null;
      },
      onFieldSubmitted: (value) {},
    );
  }

  void onTimeChanged(TimeOfDay newTime) {
    value = newTime;
    timeController.value = TextEditingValue(
        text:
            '${value.hour < 10 ? '0${value.hour}' : value.hour}:${value.minute < 10 ? '0${value.minute}' : value.minute}');
  }
}
