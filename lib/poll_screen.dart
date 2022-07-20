import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:provider/provider.dart';
import 'package:rada_poll/models/poll.dart';

import 'package:rada_poll/models/poll_data.dart';

int waitOrClickOrStart = 1;

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
  late int seconds;
  late int seconds2;
  Timer? timer1;
  Timer? timer2;
  int people = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    seconds = 10;
    seconds2 = 5;
  }

  void startTimer() {
    timer1 = Timer.periodic(Duration(seconds: 1), (timer1) {
      setState(() {
        seconds--;
      });
    });
  }

  void startTimer2() {
    timer2 = Timer.periodic(Duration(seconds: 1), (timer2) {
      if (seconds2 > 0 && waitOrClickOrStart == 1) {
        setState(() {
          seconds2--;
          people = people + 3;
          print(seconds2);
        });
      } else {
        pauseTimer2();
      }
    });
  }

  void pauseTimer1() {
    setState(() {
      timer1?.cancel();
    });
  }

  void pauseTimer2() {
    timer2?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PollData>(
      builder: (BuildContext context, pollData, Widget? child) {
        if (seconds2 == 5) {
          startTimer2();
        }
        if (seconds2 == 0) {
          seconds2 = -1;
          waitOrClickOrStart = 2;
        }

        if (seconds2 >= 6) {}

        if (seconds == 0) {
          seconds = 10;
          print('seconds' + seconds.toString());
        }

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
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Color.fromARGB(255, 212, 140, 32)],
              ),
            ),
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(20),
                child: Center(
                    child: waitOrClickOrStart == 1
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Часу до початку голосування  $seconds2 хв ',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700)),
                              SizedBox(
                                height: 20,
                              ),
                              Text('зайшло $people',
                                  style: TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700)),
                            ],
                          )
                        : waitOrClickOrStart == 2
                            ? ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    waitOrClickOrStart = 3;
                                    startTimer();
                                    print(waitOrClickOrStart);
                                  });

                                  final player = AudioCache();
                                  player.play('2.mp3');
                                },
                                child: Text('Click for start voting process'))
                            : waitOrClickOrStart == 3
                                ? ContainerOfPoll(
                                    poll: poll,
                                    days: days,
                                    seconds: seconds,
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Za zalypu   ' +
                                            pollData.polls[widget.indexOfPoll]
                                                .option[0].votes
                                                .toString(),
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 30,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        height: 100,
                                      ),
                                      Text(
                                          'proty zalypu   ' +
                                              pollData.polls[widget.indexOfPoll]
                                                  .option[1].votes
                                                  .toString(),
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 30,
                                              fontWeight: FontWeight.w700)),
                                      SizedBox(
                                        height: 100,
                                      ),
                                      Text(
                                          'pizda blyat  ' +
                                              pollData.polls[widget.indexOfPoll]
                                                  .option[2].votes
                                                  .toString(),
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 30,
                                              fontWeight: FontWeight.w700)),
                                      SizedBox(
                                        height: 100,
                                      ),
                                      Text('ne golosyvalo  ',
                                          style: TextStyle(
                                              color: Colors.teal,
                                              fontSize: 30,
                                              fontWeight: FontWeight.w700)),
                                      ElevatedButton(
                                          onPressed: () {
                                            if (pollData
                                                    .polls[widget.indexOfPoll]
                                                    .option[0]
                                                    .votes >
                                                pollData
                                                        .polls[
                                                            widget.indexOfPoll]
                                                        .option[1]
                                                        .votes +
                                                    pollData
                                                        .polls[
                                                            widget.indexOfPoll]
                                                        .option[2]
                                                        .votes) {
                                              poll.changeDecision();
                                            } else {
                                              poll.decision = false;
                                            }
                                            Navigator.popUntil(context,
                                                ModalRoute.withName('/'));
                                            poll.votedOrNo = true;
                                            waitOrClickOrStart = 1;
                                          },
                                          child: Text('завершити'))
                                    ],
                                  )),
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
    required this.seconds,
  }) : super(key: key);
  final int seconds;
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
        hasVoted: false,
        // userVotedOptionId: userVotedOptionId.value,
        onVoted: (PollOption pollOption, int newTotalVotes) async {
          await Future.delayed(Duration(seconds: seconds - 1));

          waitOrClickOrStart = 4;

          /// If HTTP status is success, return true else false
          return true;
        },
        pollEnded: days < 0,
        pollTitle: Container(
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
