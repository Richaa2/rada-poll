import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:rada_poll/models/poll_data.dart';
import 'package:rada_poll/test_screen.dart';

var people;
const kTextStyle = TextStyle(
  color: Colors.grey,
  fontSize: 22,
);
bool startedPollForModal = false;

class PollScreen extends StatefulWidget {
  final indexOfPoll;

  const PollScreen({
    Key? key,
    required this.indexOfPoll,
  }) : super(key: key);

  @override
  State<PollScreen> createState() => _PollScreenState();
}

class _PollScreenState extends State<PollScreen> {
  // int minUser = 5;
  late int seconds;
  // late int seconds2 = Provider.of<PollData>(context).seconds2;
  Timer? timer1;
  Timer? timer2;

  @override
  void initState() {
    super.initState();
    seconds = 10;
    // seconds2 = 5;
  }

  void pauseTimer2() {
    timer2?.cancel();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('waitOrClickOrStart')
            .snapshots(),
        builder: (context, snapshot) {
          return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('poll').snapshots(),
              builder: (context, snapshot2) {
                return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .snapshots(),
                    builder: (context, snapshot3) {
                      return Consumer<PollData>(builder:
                          (BuildContext context, pollData, Widget? child) {
                        void pauseTimer1() {
                          timer1?.cancel();
                        }

                        if (snapshot3.hasData &&
                            snapshot2.hasData &&
                            snapshot.hasData) {
                          print('snapshot has data');
                          var wait = pollData.waitOrClickOrStart;
                          var peopleFire = snapshot3.data!.docs
                              .firstWhere((element) => element.id == '1')
                              .get('amount');

                          // bool votedOrNo = snapshot2.data!.docs
                          //     .firstWhere(
                          //         (element) => element.id == widget.indexOfPoll)
                          //     .get('votedOrNo');

                          int yesOld = snapshot2.data!.docs
                              .firstWhere(
                                  (element) => element.id == widget.indexOfPoll)
                              .get('yes');

                          int noOld = snapshot2.data!.docs
                              .firstWhere(
                                  (element) => element.id == widget.indexOfPoll)
                              .get('no');

                          int holdOld = snapshot2.data!.docs
                              .firstWhere(
                                  (element) => element.id == widget.indexOfPoll)
                              .get('hold');

                          var question = snapshot2.data!.docs
                              .firstWhere(
                                  (element) => element.id == widget.indexOfPoll)
                              .get('question');

                          final int waitOrClickOrStartFirebase =
                              snapshot.data!.docs[0].get('waitOrClickOrStart');

                          var didNotVote =
                              peopleFire - (yesOld + noOld + holdOld);
                          didNotVote <= 0 ? didNotVote = 0 : didNotVote;
                          int allUsersPoll =
                              yesOld + noOld + holdOld + didNotVote as int;
                          // var didNotVote = snapshot2.data!.docs.firstWhere(
                          //     (element) => element.id == widget.indexOfPoll);

                          // var ints = waitOrClickOrStartFirebase;
                          // print(ints + "asdasdasdasd");

                          // if (seconds2 == 5) {
                          //   startTimer2();
                          // }
                          // if (seconds2 == 0) {
                          //   seconds2 = -1;
                          //   FirebaseFirestore.instance
                          //       .collection('waitOrClickOrStart')
                          //       .doc('1')
                          //       .update({'waitOrClickOrStart': 2});
                          // }

                          // if (seconds2 >= 6) {}
                          void startTimer() {
                            timer1 = Timer.periodic(const Duration(seconds: 1),
                                (timer1) {
                              setState(() {
                                seconds--;
                                print(seconds);
                              });
                            });
                          }

                          if (seconds == 0) {
                            seconds = 10;

                            startedPollForModal = false;

                            FirebaseFirestore.instance
                                .collection('waitOrClickOrStart')
                                .doc('1')
                                .update({'waitOrClickOrStart': 4});
                            pauseTimer1();
                          }

                          if (waitOrClickOrStartFirebase == 2) {
                            pollData.waitOrClickOrStart = 2;
                          }

                          pollData.haveOrNo = false;
                          return Scaffold(
                            body: Container(
                              decoration: waitOrClickOrStartFirebase < 4
                                  ? const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.blue,
                                          Color.fromARGB(255, 212, 140, 32)
                                        ],
                                      ),
                                    )
                                  : const BoxDecoration(color: Colors.black),
                              child: Center(
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  padding: const EdgeInsets.all(20),
                                  child: Center(
                                    child: waitOrClickOrStartFirebase == 1
                                        ? WaitZone(
                                            people: peopleFire,
                                          )
                                        : waitOrClickOrStartFirebase == 2
                                            ? SafeArea(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        'зайшло $peopleFire депутатів',
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 30,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700)),
                                                    const Spacer(
                                                      flex: 1,
                                                    ),
                                                    Text(
                                                      question,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const Spacer(
                                                      flex: 1,
                                                    ),
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary:
                                                                    peopleFire >=
                                                                            5
                                                                        ? Colors
                                                                            .green
                                                                        : Colors
                                                                            .grey),
                                                        onPressed: () {
                                                          final snackBar =
                                                              SnackBar(
                                                            content: const Text(
                                                                'Недостатня кількість депутатів'),
                                                            action:
                                                                SnackBarAction(
                                                              label: 'Закрити',
                                                              onPressed: () {},
                                                            ),
                                                          );

                                                          //Change people
                                                          if (peopleFire >= 1) {
                                                            setState(() {
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'waitOrClickOrStart')
                                                                  .doc('1')
                                                                  .update({
                                                                'waitOrClickOrStart':
                                                                    3
                                                              });
                                                              // startMusic =
                                                              //     false;
                                                              wait = 3;
                                                              final player =
                                                                  AudioCache();
                                                              player.play(
                                                                  '2.mp3');
                                                              startTimer();
                                                            });
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    snackBar);
                                                          }
                                                        },
                                                        child: const Text(
                                                          'ПОЧАТИ ГОЛОСУВАННЯ',
                                                          style: TextStyle(),
                                                        )),
                                                    const Spacer(
                                                      flex: 1,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : waitOrClickOrStartFirebase == 3
                                                ? TestScreen(
                                                    index: widget.indexOfPoll,
                                                  )
                                                : Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text(
                                                        'ПІДСУМКИ ГОЛОСУВАННЯ',
                                                        style: kTextStyle,
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Flexible(
                                                            flex: 6,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: const [
                                                                Text('ЗА',
                                                                    style:
                                                                        kTextStyle),
                                                                Text('ПРОТИ',
                                                                    style:
                                                                        kTextStyle),
                                                                Text(
                                                                    'УТРИМАЛИСЬ',
                                                                    style:
                                                                        kTextStyle),
                                                                Text(
                                                                  'НЕ ГОЛОСУВАЛО',
                                                                  style:
                                                                      kTextStyle,
                                                                  maxLines: 1,
                                                                ),
                                                                Text(
                                                                  'ВСЬОГО',
                                                                  style:
                                                                      kTextStyle,
                                                                  maxLines: 1,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const Spacer(
                                                            flex: 1,
                                                          ),
                                                          Flexible(
                                                            flex: 3,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Text(
                                                                    (yesOld
                                                                        .toString()),
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .green,
                                                                      fontSize:
                                                                          22,
                                                                    )),
                                                                Text(
                                                                    noOld
                                                                        .toString(),
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                      fontSize:
                                                                          22,
                                                                    )),
                                                                Text(
                                                                    holdOld
                                                                        .toString(),
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .yellow,
                                                                      fontSize:
                                                                          22,
                                                                    )),
                                                                Text(
                                                                    didNotVote
                                                                        .toString(),
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .teal,
                                                                      fontSize:
                                                                          22,
                                                                    )),
                                                                Text(
                                                                    allUsersPoll
                                                                        .toString(),
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          22,
                                                                    )),
                                                              ],
                                                            ),
                                                          ),
                                                          const Spacer(
                                                            flex: 2,
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      Text(
                                                          yesOld >
                                                                  noOld +
                                                                      holdOld
                                                              ? 'РІШЕННЯ ПРИЙНЯТО'
                                                              : 'РІШЕННЯ НЕ ПРИЙНЯТО',
                                                          style: TextStyle(
                                                            color: yesOld >
                                                                    noOld +
                                                                        holdOld
                                                                ? Colors.green
                                                                : Colors.red,
                                                            fontSize: 22,
                                                          )),
                                                      const SizedBox(
                                                        height: 100,
                                                      ),
                                                      ElevatedButton(
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .blueGrey
                                                                      .withOpacity(
                                                                          0.5)),
                                                        ),
                                                        onPressed: () {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'poll')
                                                              .doc(widget
                                                                  .indexOfPoll)
                                                              .update({
                                                            'votedOrNo': true
                                                          });
                                                          if (yesOld >
                                                              noOld + holdOld) {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'poll')
                                                                .doc(widget
                                                                    .indexOfPoll)
                                                                .update({
                                                              'decision': true
                                                            });
                                                            // poll.changeDecision();
                                                          } else {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'poll')
                                                                .doc(widget
                                                                    .indexOfPoll)
                                                                .update({
                                                              'decision': false
                                                            });
                                                            // poll.decision = false;
                                                          }

                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'users')
                                                              .doc('1')
                                                              .update({
                                                            'amount': 0
                                                          });

                                                          int index = snapshot2
                                                              .data!.docs
                                                              .singleWhere(
                                                                  (element) =>
                                                                      element
                                                                          .id ==
                                                                      widget
                                                                          .indexOfPoll)
                                                              .get('id');
                                                          pollData
                                                              .polls[index - 1]
                                                              .votedOrNo = true;
                                                          startedPollForModal =
                                                              false;

                                                          Navigator.of(context)
                                                              .popAndPushNamed(
                                                                  '/');

                                                          Provider.of<PollData>(
                                                                  context,
                                                                  listen: false)
                                                              .seconds2 = 5;
                                                          wait = 1;
                                                          FirebaseAuth.instance
                                                              .signOut();

                                                          // poll.votedOrNo = true;
                                                        },
                                                        child: const Text(
                                                          'завершити',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .yellow),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        return Container();
                      });
                    });
              });
        });
  }
}

class WaitZone extends StatelessWidget {
  const WaitZone({Key? key, required this.people}) : super(key: key);

  final people;

  @override
  Widget build(BuildContext context) {
    if (people == 0) {
      Navigator.pushNamed(context, '/');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(
          flex: 3,
        ),
        // Text(
        //     'Часу до початку голосування  ${seconds2} хв ',
        //     style: TextStyle(
        //         color: Colors.white,
        //         fontSize: 30,
        //         fontWeight: FontWeight.w700)),
        const Spacer(
          flex: 2,
        ),
        Text('зайшло $people депутатів',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w700)),
        const Spacer(
          flex: 3,
        ),
      ],
    );
  }
}

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
