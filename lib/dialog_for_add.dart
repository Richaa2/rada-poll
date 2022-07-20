import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import 'models/poll.dart';
import 'models/poll_data.dart';

class DialogForAdd extends StatefulWidget {
  DialogForAdd({Key? key}) : super(key: key);

  @override
  State<DialogForAdd> createState() => _DialogForAddState();
}

class _DialogForAddState extends State<DialogForAdd> {
  String questioninput = '';
  TimeOfDay Time = TimeOfDay.now();
  DateTime dateTime = DateTime.now();

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 180,
      ),
      child: SingleChildScrollView(
        child: AlertDialog(
          title: Center(child: Text('Create Poll')),
          content: Consumer<PollData>(
            builder: (context, pollData, child) =>
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Question'),
              TextFormField(
                controller: _controller,
                maxLength: 50,
                maxLines: 2,
                onChanged: (questionValue) {
                  questioninput = questionValue;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    child: Text("Choose date"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _selectTime(context);
                    },
                    child: Text("Choose time"),
                  ),
                ],
              ),
              Text("mouth: ${dateTime.month}    day:${dateTime.day}"),
              Text(
                  "hour: ${Time.hour.toString()}    min: ${Time.minute.toString()}"),
              ElevatedButton(
                  onPressed: () {
                    pollData.createPoll(Poll(
                      id: pollData.polls.last.id + 1,
                      question: questioninput,
                      endDate: pollData.selectedTime,
                      endTime: pollData.selectedTime2,
                      startDate: dateTime,
                      startTime: Time,
                      votedOrNo: false,
                    ));
                    Navigator.pop(context);
                    // Navigator.popAndPushNamed(context, '/SelectPoll');
                  },
                  child: Text('Добавити')),
            ]),
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendar,
      firstDate: DateTime.now(),
      lastDate: DateTime(2023),
    );
    if (pickedDate != null && pickedDate != dateTime) {
      setState(() {
        dateTime = pickedDate;
      });
    }
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != Time) {
      setState(() {
        Time = timeOfDay;
      });
    }
  }
}
