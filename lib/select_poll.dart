import 'package:cloud_firestore/cloud_firestore.dart';
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
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('poll').snapshots(),
        builder: (context, snapshot) {
          return Consumer<PollData>(
            builder: (context, pollData, child) {
              if (snapshot.hasData) {
                var pollsFire = snapshot.data!.docs;
                var polls = pollData.polls
                  ..sort(((a, b) => b.id.compareTo(a.id)));

                if (polls.isEmpty) {
                  if (polls.length < pollsFire.length) {
                    for (var poll in pollsFire) {
                      final accountRow = Poll(
                        decision: poll['decision'],
                        startTime: poll['startTime'],
                        endDate: poll["endDate"],
                        endTime: poll["endTime"],
                        id: poll["id"],
                        question: poll['question'],
                        startMinute: poll["startMinute"],
                        startTimestamp: poll["w"],
                        votedOrNo: poll["votedOrNo"],
                      );
                      polls.add(accountRow);
                    }
                  }
                }

                late int selectedPoll;
                if (polls.any((element) =>
                    element.startTimestamp.toDate().day == DateTime.now().day &&
                    element.startTime == TimeOfDay.now().hour &&
                    element.startMinute == TimeOfDay.now().minute &&
                    element.votedOrNo == false)) {
                  print('lol');
                  haveOrNo = true;
                  selectedPoll = pollData.polls
                          .firstWhere((element) =>
                              element.startTimestamp.toDate().day ==
                                  DateTime.now().day &&
                              element.startTime == TimeOfDay.now().hour &&
                              element.startMinute == TimeOfDay.now().minute &&
                              element.votedOrNo == false)
                          .id -
                      1;
                  print(selectedPoll);
                }

                if (polls.any((element) =>
                    element.startTimestamp.toDate().day != DateTime.now().day &&
                    element.startTime != TimeOfDay.now().hour &&
                    element.votedOrNo != false)) {
                  print('False');
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
                              child: Center(
                                child:
                                    Text('Sorry but not have poll right now'),
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
                                  child: Text('ВЕРЕТИФІКАЦІЯ'),
                                ),
                              ),
                            )),
                );
              }
              return Container();
            },
          );
        });
  }
}
