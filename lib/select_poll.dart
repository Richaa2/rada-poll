import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:rada_poll/login_screen.dart';
import 'package:rada_poll/models/poll_data.dart';
import 'package:rada_poll/poll_screen.dart';

import 'models/poll.dart';

class SelectPoll extends StatelessWidget {
  SelectPoll({Key? key}) : super(key: key);
  bool haveOrNo = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<PollData>(
      builder: (context, pollData, child) {
        late int selectedPoll;
        if (pollData.polls.any((element) =>
            element.startDate.day == DateTime.now().day &&
            element.startTime.hour == TimeOfDay.now().hour &&
            element.votedOrNo == false)) {
          print('lol');
          haveOrNo = true;
          selectedPoll = pollData.polls
                  .firstWhere((element) =>
                      element.startDate.day == DateTime.now().day &&
                      element.startTime.hour == TimeOfDay.now().hour &&
                      element.startTime.minute == TimeOfDay.now().minute &&
                      element.votedOrNo == false)
                  .id -
              1;
          print(selectedPoll);
        } else {
          haveOrNo = false;
        }
        return Container(
          child: Scaffold(
              appBar: AppBar(
                title: Text('Select poll'),
                centerTitle: true,
              ),
              body: haveOrNo == false
                  ? Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue,
                            Color.fromARGB(255, 212, 140, 32)
                          ],
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue,
                              Color.fromARGB(255, 212, 140, 32)
                            ],
                          ),
                        ),
                        child: Center(
                          child: Text('Sorry but not have poll right now'),
                        ),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue,
                            Color.fromARGB(255, 212, 140, 32)
                          ],
                        ),
                      ),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen(
                                          indexOfPoll: selectedPoll,
                                        )));
                          },
                          child: Text('Auntefication'),
                        ),
                      ),
                    )),
        );
      },
    );
  }
}
