import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:provider/provider.dart';
import 'package:rada_poll/models/poll.dart';

import 'package:rada_poll/models/poll_data.dart';

class PollScreen extends StatefulWidget {
  int indexOfPoll;
  PollScreen({
    Key? key,
    required this.indexOfPoll,
  }) : super(key: key);

  @override
  State<PollScreen> createState() => _PollScreenState();
}

class _PollScreenState extends State<PollScreen> {
  int waitOrClickOrStart = 2;

  @override
  Widget build(BuildContext context) {
    return Consumer<PollData>(
      builder: (BuildContext context, pollData, Widget? child) {
        final poll = pollData.polls[widget.indexOfPoll];

        final int days = DateTime(
          poll.endDate.year,
          poll.endDate.month,
          poll.endDate.day,
        )
            .difference(DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            ))
            .inDays;

        return Scaffold(
          appBar: AppBar(title: const Text('Rada Poll')),
          body: Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(20),
              child: Center(
                child: waitOrClickOrStart == 1
                    ? Text("Wait for others")
                    : waitOrClickOrStart == 2
                        ? ElevatedButton(
                            onPressed: () {
                              setState(() {
                                waitOrClickOrStart = 3;
                              });
                            },
                            child: Text('Click for start voting process'))
                        : ContainerOfPoll(poll: poll, days: days),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ContainerOfPoll extends StatelessWidget {
  const ContainerOfPoll({
    Key? key,
    required this.poll,
    required this.days,
  }) : super(key: key);

  final Poll poll;
  final int days;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      margin: const EdgeInsets.only(bottom: 20),
      child: FlutterPolls(
        pollId: poll.id.toString(),
        // hasVoted: hasVoted.value,
        // userVotedOptionId: userVotedOptionId.value,
        onVoted: (PollOption pollOption, int newTotalVotes) async {
          await Future.delayed(const Duration(seconds: 2));

          /// If HTTP status is success, return true else false
          return true;
        },
        pollEnded: days < 0,
        pollTitle: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            poll.question + poll.id.toString(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        pollOptions: List<PollOption>.from(poll.option),
        votedPercentageTextStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        metaWidget: Row(
          children: [
            const SizedBox(width: 6),
            const Text(
              '•',
            ),
            const SizedBox(
              width: 6,
            ),
            Text(
              days < 0 ? "ended" : "ends $days days",
            ),
          ],
        ),
      ),
    );
  }
}