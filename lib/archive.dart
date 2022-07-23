import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:rada_poll/models/poll_data.dart';

import 'models/poll.dart';

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pollsEmpty =
        Provider.of<PollData>(context, listen: false).polls.isEmpty;
    return Consumer<PollData>(
      builder: (context, pollData, child) {
        String minute = '';
        var poll = pollData.polls.where((element) => element.votedOrNo == true);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Минулі голосування',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            actions: [
              IconButton(
                  onPressed: pollsEmpty
                      ? () {
                          Provider.of<PollData>(context, listen: false).addPoll(
                              Poll(
                                  id: 0,
                                  question: 'question',
                                  startTime: TimeOfDay.now().minute,
                                  startMinute: TimeOfDay.now().hour,
                                  startTimestamp: Timestamp.now()));
                          print('create');
                        }
                      : () {},
                  icon: Icon(Icons.add_circle_outlined))
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Color.fromARGB(255, 212, 140, 32)],
              ),
            ),
            child: ListView.builder(
              itemCount: poll.length,
              itemBuilder: (context, index) {
                if (poll.elementAt(index).startMinute < 10) {
                  minute = '0' + poll.elementAt(index).startMinute.toString();
                } else {
                  minute = poll.elementAt(index).startMinute.toString();
                }
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Container(
                      color: Colors.amber.withOpacity(0.6),
                      height: 70,
                      child: ListTile(
                        leading: Text(poll.elementAt(index).id.toString()),
                        title: Text(poll.elementAt(index).question),
                        subtitle: Row(
                          children: [
                            Text(
                              'час початку  ' +
                                  poll.elementAt(index).startTime.toString() +
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
                                  poll
                                      .elementAt(index)
                                      .startTimestamp
                                      .toDate()
                                      .month
                                      .toString() +
                                  '.' +
                                  poll
                                      .elementAt(index)
                                      .startTimestamp
                                      .toDate()
                                      .day
                                      .toString(),
                              style: TextStyle(
                                color: poll.elementAt(index).decision
                                    ? Color.fromARGB(255, 15, 124, 18)
                                    : Color.fromARGB(255, 160, 23, 13),
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      )),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
