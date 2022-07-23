import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:rada_poll/dialog_for_add.dart';
import 'package:rada_poll/models/poll.dart';
import 'package:rada_poll/models/poll_data.dart';

class AddPollScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String questioninput = '';
    String minute = '';

    TextEditingController _controller = TextEditingController();
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('poll')
            .orderBy('w')
            .snapshots(),
        builder: (context, snapshot) {
          return Consumer<PollData>(builder: (context, pollData, child) {
            if (snapshot.hasData) {
              var polls = pollData.polls;
              var pollsFire = snapshot.data!.docs;

              final pollLast = snapshot.data!.docs.last;

              if (polls.isEmpty) {
                if (polls.length < pollsFire.length) {
                  for (var poll in pollsFire) {
                    final accountRow = Poll(
                      decision: poll['decision'],
                      startTime: poll['startTime'],
                      // endDate: poll["endDate"],
                      // endTime: poll["endTime"],
                      id: poll["id"],
                      question: poll['question'],
                      startMinute: poll["startMinute"],
                      startTimestamp: poll["w"],
                      votedOrNo: poll["votedOrNo"],
                      yes: poll["yes"],
                      no: poll['no'],
                      didNotVote: poll['didNotVote'],
                      hold: poll['hold'],
                    );
                    polls.add(accountRow);
                  }
                }
              }
              // if (pollsFire.length > polls.length) {
              //   polls.insert(
              //       polls.length - 1,
              //       Poll(
              //         decision: pollLast['decision'],
              //         startTime: pollLast['startTime'],
              //         endDate: pollLast["endDate"],
              //         endTime: pollLast["endTime"],
              //         id: pollLast["id"],
              //         question: pollLast['question'],
              //         startMinute: pollLast["startMinute"],
              //         startTimestamp: pollLast["w"],
              //         votedOrNo: pollLast["votedOrNo"],
              //         yes: pollLast["yes"],
              //         no: pollLast['no'],
              //         didNotVote: pollLast['didNotVote'],
              //         hold: pollLast['hold'],
              //       ));
              // }

              var pollVotedNo = polls.reversed.where((element) =>
                  element.votedOrNo == false &&
                  element.startTimestamp.toDate().day >= DateTime.now().day);

              print(polls.length);
              print(Timestamp.now().toDate());
              print(Timestamp.now().seconds);

              if (polls.length != pollsFire) {
                polls.clear();
                for (var poll in pollsFire) {
                  final accountRow = Poll(
                    decision: poll['decision'],
                    startTime: poll['startTime'],
                    id: poll["id"],
                    question: poll['question'],
                    startMinute: poll["startMinute"],
                    startTimestamp: poll["w"],
                    votedOrNo: poll["votedOrNo"],
                    yes: poll["yes"],
                    no: poll['no'],
                    didNotVote: poll['didNotVote'],
                    hold: poll['hold'],
                  );
                  polls.add(accountRow);
                }
              }

              return Scaffold(
                appBar: AppBar(
                  actions: [
                    IconButton(
                      icon: Icon(
                        Icons.add,
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => DialogForAdd());
                      },
                    )
                  ],
                  title: Text(
                    'Майбутні голосування',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  centerTitle: true,
                ),
                body: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, Color.fromARGB(255, 212, 140, 32)],
                    ),
                  ),
                  child: Column(
                    children: [
                      //TODO listTile
                      Expanded(
                        child: ListView.builder(
                          itemCount: pollVotedNo.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (snapshot.hasData) {
                              if (pollVotedNo.elementAt(index).startMinute <
                                  10) {
                                minute = '0' +
                                    pollVotedNo
                                        .elementAt(index)
                                        .startMinute
                                        .toString();
                              } else {
                                minute = pollVotedNo
                                    .elementAt(index)
                                    .startMinute
                                    .toString();
                              }
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 20),
                                child: Container(
                                    color: Colors.amber.withOpacity(0.6),
                                    height: 70,
                                    child: ListTile(
                                      leading: Text(pollVotedNo
                                          .elementAt(index)
                                          .id
                                          .toString()),
                                      title: Text(pollVotedNo
                                          .elementAt(index)
                                          .question),
                                      subtitle: Row(
                                        children: [
                                          Text(
                                            'час початку  ' +
                                                pollVotedNo
                                                    .elementAt(index)
                                                    .startTime
                                                    .toString() +
                                                ':' +
                                                minute,

                                            style: TextStyle(
                                                color: Colors.indigo[500],
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                            // poll.elementAt(index).startDate.day.toString()
                                          ),
                                          Spacer(
                                            flex: 1,
                                          ),
                                          Text(
                                            ' число  ' +
                                                pollVotedNo
                                                    .elementAt(index)
                                                    .startTimestamp
                                                    .toDate()
                                                    .month
                                                    .toString() +
                                                '.' +
                                                pollVotedNo
                                                    .elementAt(index)
                                                    .startTimestamp
                                                    .toDate()
                                                    .day
                                                    .toString(),
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    )),
                              );
                            }
                            return Container();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            return SizedBox();
          });
        });
  }
}
