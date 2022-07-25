import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:rada_poll/dialog_for_add.dart';
import 'package:rada_poll/models/poll.dart';
import 'package:rada_poll/models/poll_data.dart';

class AddPollScreen extends StatelessWidget {
  const AddPollScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String minute = '';

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

              // final pollLast = snapshot.data!.docs.last;

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
        

              var pollVotedNo = polls.reversed.where((element) =>
                  element.votedOrNo == false &&
                  element.startTimestamp.toDate().day >= DateTime.now().day);

           

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
                      icon: const Icon(
                        Icons.add,
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => const DialogForAdd());
                      },
                    )
                  ],
                  title: const Text(
                    'Майбутні голосування',
                    style:  TextStyle(fontWeight: FontWeight.w600),
                  ),
                  centerTitle: true,
                ),
                body: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, Color.fromARGB(255, 212, 140, 32)],
                    ),
                  ),
                  child: Column(
                    children: [
                
                      Expanded(
                        child: ListView.builder(
                          itemCount: pollVotedNo.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (snapshot.hasData) {
                              if (pollVotedNo.elementAt(index).startMinute <
                                  10) {
                                minute = '0${pollVotedNo
                                        .elementAt(index)
                                        .startMinute}';
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
                                            'час початку  ${pollVotedNo
                                                    .elementAt(index)
                                                    .startTime}:$minute',

                                            style: TextStyle(
                                                color: Colors.indigo[500],
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                            // poll.elementAt(index).startDate.day.toString()
                                          ),
                                          const Spacer(
                                            flex: 1,
                                          ),
                                          Text(
                                            ' число  ${pollVotedNo
                                                    .elementAt(index)
                                                    .startTimestamp
                                                    .toDate()
                                                    .month}.${pollVotedNo
                                                    .elementAt(index)
                                                    .startTimestamp
                                                    .toDate()
                                                    .day}',
                                            style: const TextStyle(
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
            return const SizedBox();
          });
        });
  }
}
