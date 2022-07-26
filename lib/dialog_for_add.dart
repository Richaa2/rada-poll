import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'models/poll.dart';
import 'models/poll_data.dart';

class DialogForAdd extends StatefulWidget {
  const DialogForAdd({Key? key}) : super(key: key);

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

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 180,
      ),
      child: SingleChildScrollView(
        child: AlertDialog(
          title: const Center(
              child: Text(
            'Створіть Голосування',
            style: TextStyle(fontWeight: FontWeight.w600),
          )),
          content: Consumer<PollData>(
            builder: (context, pollData, child) =>
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                'Введіть назву',
                style: const TextStyle(fontWeight: FontWeight.w600),
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
                    child: const Text(
                      "Виберіть дату",
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectTime(context);
                      });
                    },
                    child: const Text(
                      "Виберіть час",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Text(
                "Місяць: ${dateTime.month}    День:${dateTime.day}",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                "Година: ${Time.hour.toString()}    Хвилина: ${Time.minute.toString()}",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName('/Add'));
                    pollData.addPoll(Poll(
                      id: pollData.polls.length,
                      question: questioninput,
                      // endDate: pollData.selectedTime.millisecondsSinceEpoch,
                      // endTime: pollData.selectedTime2.hour,
                      // startDate: dateTime.millisecondsSinceEpoch,

                      startTime: Time.hour,
                      startMinute: Time.minute,
                      votedOrNo: false,
                      startTimestamp: Timestamp.fromDate(DateTime(
                          dateTime.year,
                          dateTime.month,
                          dateTime.day,
                          Time.hour,
                          Time.minute)),
                    ));

                    // Navigator.popAndPushNamed(context, '/SelectPoll');
                  },
                  child: const Text(
                    'Добавити',
                    style: const TextStyle(fontWeight: FontWeight.w600),
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
        print(dateTime);
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
        print(Time);
      });
    }
  }
}
