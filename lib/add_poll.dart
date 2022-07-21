import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:rada_poll/dialog_for_add.dart';
import 'package:rada_poll/models/poll.dart';
import 'package:rada_poll/models/poll_data.dart';

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
    return Consumer<PollData>(builder: (context, pollData, child) {
      var poll = pollData.polls.where((element) => element.votedOrNo == false);
      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(
                Icons.add,
              ),
              onPressed: () {
                showDialog(
                    context: context, builder: (context) => DialogForAdd());
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
                  itemCount: poll.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 20),
                      child: Container(
                          color: Colors.amber.withOpacity(0.6),
                          height: 70,
                          child: ListTile(
                            title: Text(poll.elementAt(index).question),
                            subtitle: Text('час початку  ' +
                                poll
                                    .elementAt(index)
                                    .startTime
                                    .hour
                                    .toString() +
                                ':' +
                                poll
                                    .elementAt(index)
                                    .startTime
                                    .minute
                                    .toString() +
                                ' число  ' +
                                poll.elementAt(index).startDate.day.toString()),
                          )),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
