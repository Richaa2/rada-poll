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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("poll")
            .orderBy(
              "id",
            )
            .snapshots(),
        builder: (context, snapshot) {
          return Consumer<PollData>(
            builder: (context, pollData, child) {
              if (snapshot.hasData) {
                // ..sort(((a, b) => b.id.compareTo(a.id)));
                var pollsFire = snapshot.data!.docs;
                var polls = pollData.polls;
                if (polls.isEmpty) {
                  if (polls.length < pollsFire.length) {
                    for (var poll in pollsFire) {
                      final accountRow = Poll(
                        decision: poll['decision'],
                        startTime: poll['startTime'],
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

                print('selected Screen');

                String selectedPoll = '';
                var numberPoll = 0;

                if (pollsFire.any((element) =>
                        element.get('votedOrNo') == false &&
                        element.get('startTime') == TimeOfDay.now().hour &&
                        element.get('startMinute') >= TimeOfDay.now().minute - 5
                    // &&
                    // element.get('startMinute') >= TimeOfDay.now().minute - 5
                    )) {
                  // selectedPoll = polls.indexWhere((element) =>
                  //     element.startTimestamp.toDate().day ==
                  //         DateTime.now().day &&
                  //     element.startTime == TimeOfDay.now().hour &&
                  //     element.startMinute == TimeOfDay.now().minute &&
                  //     element.votedOrNo == false);
                  pollData.haveOrNo = true;
                  print('Selected Widget');
                  selectedPoll = pollsFire
                      .lastWhere((element) =>
                          // element.get('w') ==
                          //     Timestamp.fromDate(DateTime.now()) &&
                          element.get('votedOrNo') == false &&
                          element.get('startTime') == TimeOfDay.now().hour &&
                          element.get('startMinute') >=
                              TimeOfDay.now().minute - 5)
                      .id;
                  numberPoll = snapshot.data!.docs
                      .singleWhere((element) => element.id == selectedPoll)
                      .get('id');
                  print('index ' + selectedPoll);

                  print(pollData.polls.first.id);
                } else {
                  pollData.haveOrNo = false;
                  print('Faalse have or not');
                }

                // if (polls.any((element) =>
                //     element.startTimestamp.toDate().day != DateTime.now().day &&
                //     element.startTime != TimeOfDay.now().hour &&
                //     element.votedOrNo != false)) {
                //   print('False');
                //   pollData.haveOrNo = false;
                // }
                return Container(
                  child: Scaffold(
                      appBar: AppBar(
                        title: Text(
                          'Теперішні голосування',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        centerTitle: true,
                      ),
                      body: pollData.haveOrNo == false
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
                                child: Text(
                                  'На даний момент немає голосування',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Text(
                                    'Голосування номер $numberPoll',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        print(selectedPoll);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen(
                                                      iid: selectedPoll,
                                                    )));
                                      },
                                      child: Text('ВЕРЕТИФІКАЦІЯ'),
                                    ),
                                  ),
                                  Spacer(
                                    flex: 2,
                                  ),
                                ],
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
