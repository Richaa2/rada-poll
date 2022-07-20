import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:rada_poll/models/poll.dart';
import 'package:rada_poll/models/poll_data.dart';

DateTime selectedTime = DateTime.now();

class AddPollScreen extends StatefulWidget {
  const AddPollScreen({Key? key}) : super(key: key);

  @override
  State<AddPollScreen> createState() => _AddPollScreenState();
}

class _AddPollScreenState extends State<AddPollScreen> {
  @override
  Widget build(BuildContext context) {
    String questioninput = '';

    TextEditingController _controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Poll'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text('Question'),
          TextFormField(
            controller: _controller,
            maxLength: 200,
            maxLines: 5,
            onChanged: (questionValue) {
              questioninput = questionValue;
            },
          ),
          ElevatedButton(
            onPressed: () {
              _selectTime(context);
            },
            child: Text("Choose Time"),
          ),
          Text("mouth: ${selectedTime.month}    day:${selectedTime.day}"),
          ElevatedButton(
              onPressed: () {
                Provider.of<PollData>(context, listen: false).polls.add(Poll(
                      id: Provider.of<PollData>(context, listen: false)
                              .polls
                              .last
                              .id +
                          1,
                      question: questioninput,
                      endDate: selectedTime,
                    ));
                Navigator.popAndPushNamed(context, '/SelectPoll');
              },
              child: Text('Добавити'))
        ],
      ),
    );
  }

  _selectTime(BuildContext context) async {
    final DateTime? timeOfDay = await showDatePicker(
      context: context,
      initialDate: selectedTime,
      initialEntryMode: DatePickerEntryMode.calendar,
      firstDate: DateTime.now(),
      lastDate: DateTime(2023),
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }
}
