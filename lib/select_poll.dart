import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:rada_poll/models/poll_data.dart';
import 'package:rada_poll/poll_screen.dart';

class SelectPoll extends StatelessWidget {
  const SelectPoll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PollData>(
      builder: (context, pollData, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Select poll'),
              centerTitle: true,
            ),
            body: ListView.builder(
              itemCount: pollData.polls.length,
              itemBuilder: ((context, index) {
                return InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PollScreen(indexOfPoll: index))),
                  child: SizedBox(
                      width: 200,
                      height: 200,
                      child: Card(
                        color: Colors.amber,
                        child:
                            Center(child: Text(pollData.polls[index].question)),
                      )),
                );
              }),
            ));
      },
    );
  }
}
