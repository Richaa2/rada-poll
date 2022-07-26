import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:rada_poll/login_screen.dart';
import 'package:rada_poll/models/poll_data.dart';

import 'models/poll.dart';

class SelectPoll extends StatelessWidget {
  const SelectPoll({Key? key}) : super(key: key);

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
                // ..sort(((a, b) => b.id.compareTo(a.id)));

                print('123123');

                String selectedPoll = '';
                var numberPoll = 0;

                if (pollsFire.any((element) =>
                            element.get('votedOrNo') == false &&
                            element.get('startTime') == TimeOfDay.now().hour &&
                            element.get('startMinute') >=
                                TimeOfDay.now().minute &&
                            element.get('startMinute') - 5 <
                                TimeOfDay.now().minute

                        // &&
                        // element.get('startMinute') >= TimeOfDay.now().minute - 5
                        ) &&
                    polls.any((element) =>
                        element.votedOrNo == false &&
                        element.startTimestamp.seconds >=
                            Timestamp.now().seconds - 100)) {
                  pollData.haveOrNo = true;
                  var pollVotedNo = polls.firstWhere((element) =>
                      element.votedOrNo == false &&
                      element.startTimestamp.seconds >=
                          Timestamp.now().seconds - 100);
                  selectedPoll = pollsFire
                      .firstWhere((element) =>
                              // element.get('w') <=
                              //     Timestamp.fromDate(DateTime.now()) &&

                              element.get('id') == pollVotedNo.id

                          // element.get('votedOrNo') == false &&
                          //     element.get('startTime') <=
                          //         TimeOfDay.now().hour &&
                          //     element.get('startMinute') - 5 <=
                          //         TimeOfDay.now().minute &&
                          //     TimeOfDay.now().minute - 1 <=
                          //         element.get('startMinute') ||
                          // TimeOfDay.now().minute ==
                          //         element.get('startMinute') &&
                          //     element.get('votedOrNo') == false &&
                          //     element.get('startTime') ==
                          //         TimeOfDay.now().hour

                          //     &&
                          // element.get('startMinute') < TimeOfDay.now().minute

                          )
                      .id;
                  numberPoll = snapshot.data!.docs
                      .singleWhere((element) => element.id == selectedPoll)
                      .get('id');
                } else {
                  pollData.haveOrNo = false;
                }

                // if (polls.any((element) =>
                //     element.startTimestamp.toDate().day != DateTime.now().day &&
                //     element.startTime != TimeOfDay.now().hour &&
                //     element.votedOrNo != false)) {
                //   print('False');
                //   pollData.haveOrNo = false;
                // }
                return Scaffold(
                    appBar: AppBar(
                      title: const Text(
                        'Теперішні голосування',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      centerTitle: true,
                    ),
                    body: pollData.haveOrNo == false
                        ? Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue,
                                  Color.fromARGB(255, 212, 140, 32)
                                ],
                              ),
                            ),
                            child: const Center(
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
                            decoration: const BoxDecoration(
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
                                const Spacer(
                                  flex: 1,
                                ),
                                Text(
                                  'Голосування номер $numberPoll',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => LoginScreen(
                                                    iid: selectedPoll,
                                                  )));
                                    },
                                    child: const Text('ВЕРЕТИФІКАЦІЯ'),
                                  ),
                                ),
                                const Spacer(
                                  flex: 2,
                                ),
                              ],
                            ),
                          ));
              }
              return Container();
            },
          );
        });
  }
}
