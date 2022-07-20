import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:rada_poll/models/poll_data.dart';

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PollData>(
      builder: (context, pollData, child) {
        var poll = pollData.polls.where((element) => element.votedOrNo == true);
        return Scaffold(
          appBar: AppBar(title: Text('Archive')),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Color.fromARGB(255, 212, 140, 32)],
              ),
            ),
            child: ListView.builder(
              itemCount: poll.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Container(
                      color: Colors.amber,
                      height: 70,
                      child: ListTile(
                          title: Text(poll.elementAt(index).question),
                          subtitle: Text('час початку  ' +
                              pollData.polls[index].startTime.hour.toString() +
                              ':' +
                              pollData.polls[index].startTime.minute
                                  .toString() +
                              ' число  ' +
                              pollData.polls[index].startDate.day.toString()),
                          trailing: poll.elementAt(index).decision
                              ? Text('Рішення прийнято')
                              : Text('Рішення не прийнято'))),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
