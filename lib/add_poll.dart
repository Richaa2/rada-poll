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

    TextEditingController _controller = TextEditingController();
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('poll').snapshots(),
        builder: (context, snapshot) {
          return Consumer<PollData>(builder: (context, pollData, child) {
            if (snapshot.hasData) {
              var pollsFire = snapshot.data!.docs;
              var polls = pollData.polls;
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
                      yes: poll["yes"],
                      no: poll['no'],
                      didNotVote: poll['didNotVote'],
                      hold: poll['hold'],
                    );
                    polls.add(accountRow);
                  }
                }
              }
              print(polls.length);

              var pollVotedNo =
                  polls.where((element) => element.votedOrNo == false);
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
                  title: Text('Create Poll'),
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
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 20),
                              child: Container(
                                  color: Colors.amber.withOpacity(0.6),
                                  height: 70,
                                  child: ListTile(
                                    title: Text(
                                        pollVotedNo.elementAt(index).question),
                                    subtitle: Text('час початку  ' +
                                            pollVotedNo
                                                .elementAt(index)
                                                .startTime
                                                .toString() +
                                            ':' +
                                            pollVotedNo
                                                .elementAt(index)
                                                .startMinute
                                                .toString() +
                                            ' число  '
                                        // poll.elementAt(index).startDate.day.toString()
                                        ),
                                  )),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            return Container();
          });
        });
  }
}
