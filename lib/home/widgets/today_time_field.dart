import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:haru/common/const_values.dart';
import 'package:intl/intl.dart';

class TodayTimeField extends StatelessWidget {
  DateTime time;
  String labelText;
  TextEditingController timeController;
  TextEditingController otherTimeController;

  TodayTimeField({
    Key? key,
    required this.time,
    required this.labelText,
    required this.timeController,
    required this.otherTimeController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      controller: timeController,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      format: DateFormat("HH:mm"),
      onShowPicker: (context, currentValue) async {
        Navigator.of(context).push(
          showPicker(
            context: context,
            value: TimeOfDay.fromDateTime(time),
            is24HrFormat: true,
            onChange: onTimeChanged,
          ),
        );
        return Future.value(null);
      },
      validator: (value) {
        if (value == null) {
          return 'Please enter $labelText';
        }

        if (otherTimeController.text.isNotEmpty) {
          final otherText = otherTimeController.text;
          final hour = int.parse(otherText.split(":")[0]);
          final minute = int.parse(otherText.split(":")[1]);
          final otherValue =
              DateTime(value.year, value.month, value.day, hour, minute);
          if (labelText == 'Start Time' && !value.isBefore(otherValue)) {
            return '$labelText must come before the End Time';
          }

          if (labelText == 'End Time' && !value.isAfter(otherValue)) {
            return '$labelText must come after the Start Time';
          }
        }

        return null;
      },
    );
  }

  void onTimeChanged(TimeOfDay newTime) {
    time = getTime(newTime.hour, newTime.minute);
    timeController.text =
        '${padLeftForTime(newTime.hour)}:${padLeftForTime(newTime.minute)}';
  }
}
