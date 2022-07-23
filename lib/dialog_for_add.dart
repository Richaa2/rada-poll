import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
          title: Center(
              child: Text(
            'Створіть Голосування',
            style: TextStyle(fontWeight: FontWeight.w600),
          )),
          content: Consumer<PollData>(
            builder: (context, pollData, child) =>
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Введіть назву',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              TextFormField(
                // inputFormatters: [
                //   FilteringTextInputFormatter.allow(RegExp("^[а-яА-Я]+\$"))
                // ],
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
                      setState(() {
                        _selectDate(context);
                      });
                    },
                    child: Text(
                      "Виберіть час",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectTime(context);
                      });
                    },
                    child: Text(
                      "Виберіть дату",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Text(
                "mouth: ${dateTime.month}    day:${dateTime.day}",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                "hour: ${Time.hour.toString()}    min: ${Time.minute.toString()}",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                    pollData.addPoll(Poll(
                      id: pollData.polls.length,
                      question: questioninput,
                      // endDate: pollData.selectedTime.millisecondsSinceEpoch,
                      // endTime: pollData.selectedTime2.hour,
                      // startDate: dateTime.millisecondsSinceEpoch,
                      startTime: Time.hour,
                      startMinute: Time.minute,
                      votedOrNo: false,
                      startTimestamp: Timestamp.fromDate(dateTime),
                    ));

                    // Navigator.popAndPushNamed(context, '/SelectPoll');
                  },
                  child: Text(
                    'Добавити',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )),
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
