import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:provider/provider.dart';

import 'package:rada_poll/models/poll.dart';
import 'package:rada_poll/models/poll_data.dart';
import 'package:rada_poll/test_screen.dart';

const kTextStyle = TextStyle(
  color: Colors.grey,
  fontSize: 22,
);
bool startedPoll = false;

class PollScreen extends StatefulWidget {
  var indexOfPoll;

  PollScreen({
    Key? key,
    required this.indexOfPoll,
  }) : super(key: key);

  @override
  State<PollScreen> createState() => _PollScreenState();
}

class _PollScreenState extends State<PollScreen> {
  late int seconds;
  // late int seconds2 = Provider.of<PollData>(context).seconds2;
  Timer? timer1;
  Timer? timer2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    seconds = 10;
    // seconds2 = 5;
  }

  void startTimer() {
    timer1 = Timer.periodic(Duration(seconds: 1), (timer1) {
      setState(() {
        seconds--;
        print(seconds);
      });
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

  // void startTimer2() {
  //   timer2 = Timer.periodic(Duration(seconds: 1), (timer2) {
  //     if (seconds2 > 0 &&
  //         Provider.of<PollData>(context, listen: false).waitOrClickOrStart ==
  //             1) {
  //       setState(() {
  //         FirebaseFirestore.instance
  //             .collection('waitOrClickOrStart')
  //             .doc('1')
  //             .update({'waitOrClickOrStart': 1});
  //         seconds2--;
  //         people = people + 3;
  //         print('indexx' + widget.indexOfPoll.toString());
  //       });
  //     } else {
  //       pauseTimer2();
  //     }
  //   });
  // }

  @override
  void dispose() {
    // TODO: implement dispose
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
                        if (snapshot3.hasData &&
                            snapshot2.hasData &&
                            snapshot.hasData) {
                          print('12312313');
                          var wait = pollData.waitOrClickOrStart;
                          var people = snapshot3.data!.docs
                              .firstWhere((element) => element.id == '1')
                              .get('amount');
                          var votedOrNo = snapshot2.data!.docs
                              .firstWhere(
                                  (element) => element.id == widget.indexOfPoll)
                              .get('votedOrNo');
                          var yesOld = snapshot2.data!.docs
                              .firstWhere(
                                  (element) => element.id == widget.indexOfPoll)
                              .get('yes');
                          var noOld = snapshot2.data!.docs
                              .firstWhere(
                                  (element) => element.id == widget.indexOfPoll)
                              .get('no');
                          var holdOld = snapshot2.data!.docs
                              .firstWhere(
                                  (element) => element.id == widget.indexOfPoll)
                              .get('hold');
                          var question = snapshot2.data!.docs
                              .firstWhere(
                                  (element) => element.id == widget.indexOfPoll)
                              .get('question');
                          final int waitOrClickOrStartFirebase =
                              snapshot.data!.docs[0].get('waitOrClickOrStart');

                          var didNotVote = people - (yesOld + noOld + holdOld);
                          didNotVote <= 0 ? didNotVote = 0 : didNotVote;
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

                          if (seconds == 0) {
                            seconds = 10;
                            print('seconds' + seconds.toString());
                            startedPoll = false;
                            print(startedPoll);
                            FirebaseFirestore.instance
                                .collection('waitOrClickOrStart')
                                .doc('1')
                                .update({'waitOrClickOrStart': 4});
                          }

                          if (waitOrClickOrStartFirebase == 2) {
                            pollData.waitOrClickOrStart = 2;
                          }
                          if (waitOrClickOrStartFirebase == 3) {
                            pollData.waitOrClickOrStart = 3;
                          }
                          if (waitOrClickOrStartFirebase == 4) {
                            pollData.waitOrClickOrStart = 4;
                          }

                          // final poll = pollData.polls[widget.indexOfPoll];

                          // final int days = DateTime(
                          //   poll.endDate.year,
                          //   poll.endDate.month,
                          //   poll.endDate.day,
                          // )
                          //     .difference(DateTime(
                          //       DateTime.now().year,
                          //       DateTime.now().month,
                          //       DateTime.now().day,
                          //     ))
                          //     .inDays;

                          // TODO users logined
                          return Scaffold(
                            body: Container(
                              decoration: waitOrClickOrStartFirebase < 4
                                  ? BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.blue,
                                          Color.fromARGB(255, 212, 140, 32)
                                        ],
                                      ),
                                    )
                                  : BoxDecoration(color: Colors.black),
                              child: Center(
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  padding: const EdgeInsets.all(20),
                                  child: Center(
                                      child: waitOrClickOrStartFirebase == 1
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Spacer(
                                                  flex: 3,
                                                ),
                                                // Text(
                                                //     'Часу до початку голосування  ${seconds2} хв ',
                                                //     style: TextStyle(
                                                //         color: Colors.white,
                                                //         fontSize: 30,
                                                //         fontWeight: FontWeight.w700)),
                                                Spacer(
                                                  flex: 2,
                                                ),
                                                Text('зайшло $people',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.w700)),
                                                Spacer(
                                                  flex: 3,
                                                ),
                                              ],
                                            )
                                          : waitOrClickOrStartFirebase == 2
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Spacer(
                                                      flex: 1,
                                                    ),
                                                    Text(
                                                      question,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Spacer(
                                                      flex: 1,
                                                    ),
                                                    ElevatedButton(
                                                        onPressed: () {
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

                                                            wait = 3;
                                                            startTimer();
                                                            print(wait);
                                                          });

                                                          final player =
                                                              AudioCache();
                                                          player.play('2.mp3');
                                                        },
                                                        child: Text(
                                                          'ПОЧАТИ ГОЛОСУВАННЯ',
                                                        )),
                                                    Spacer(
                                                      flex: 1,
                                                    ),
                                                  ],
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
                                                        Text(
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
                                                                children: [
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
                                                            Spacer(
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
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .green,
                                                                        fontSize:
                                                                            22,
                                                                      )),
                                                                  Text(
                                                                      noOld
                                                                          .toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .red,
                                                                        fontSize:
                                                                            22,
                                                                      )),
                                                                  Text(
                                                                      holdOld
                                                                          .toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .yellow,
                                                                        fontSize:
                                                                            22,
                                                                      )),
                                                                  Text(
                                                                      didNotVote
                                                                          .toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .teal,
                                                                        fontSize:
                                                                            22,
                                                                      )),
                                                                  Text(
                                                                      people
                                                                          .toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontSize:
                                                                            22,
                                                                      )),
                                                                ],
                                                              ),
                                                            ),
                                                            Spacer(
                                                              flex: 2,
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Text('РІШЕННЯ ПРИЙНЯТО',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 22,
                                                            )),
                                                        SizedBox(
                                                          height: 100,
                                                        ),
                                                        ElevatedButton(
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty.all(Colors
                                                                      .blueGrey
                                                                      .withOpacity(
                                                                          0.5)),
                                                            ),
                                                            onPressed: () {
                                                              if (yesOld >
                                                                  noOld +
                                                                      holdOld) {
                                                                // poll.changeDecision();
                                                              } else {
                                                                // poll.decision = false;
                                                              }

                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'waitOrClickOrStart')
                                                                  .doc('1')
                                                                  .update({
                                                                'waitOrClickOrStart':
                                                                    2
                                                              });

                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'users')
                                                                  .doc('1')
                                                                  .update({
                                                                'amount': 0
                                                              });

                                                              FirebaseAuth
                                                                  .instance
                                                                  .signOut();
                                                              Navigator.popUntil(
                                                                  context,
                                                                  ModalRoute
                                                                      .withName(
                                                                          '/'));
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'poll')
                                                                  .doc(widget
                                                                      .indexOfPoll)
                                                                  .update({
                                                                'votedOrNo':
                                                                    true
                                                              });
                                                              // poll.votedOrNo = true;
                                                              wait = 1;
                                                              Provider.of<PollData>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .seconds2 = 5;
                                                            },
                                                            child: Text(
                                                              'завершити',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .yellow),
                                                            ))
                                                      ],
                                                    )),
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

// class ContainerOfPoll extends StatelessWidget {
//   const ContainerOfPoll({
//     Key? key,
//     required this.poll,
//     // required this.days,
//     required this.seconds,
//   }) : super(key: key);
//   final int seconds;
//   final Poll poll;
//   // final int days;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 300,
//       height: 500,
//       margin: const EdgeInsets.only(bottom: 20),
//       child: Expanded(
//         child: FlutterPolls(
//           pollId: poll.id.toString(),
//           hasVoted: false,
//           // userVotedOptionId: userVotedOptionId.value,
//           onVoted: (PollOption pollOption, int newTotalVotes) async {
//             await Future.delayed(Duration(seconds: seconds - 2));

//             waitOrClickOrStart = 4;

//             /// If HTTP status is success, return true else false
//             return true;
//           },
//           // pollEnded: days < 0,
//           pollTitle: Container(
//             alignment: Alignment.centerLeft,
//             child: Column(
//               children: [
//                 Center(
//                   child: Text(
//                     'id: ' + poll.id.toString() + '    ' + poll.question,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 150,
//                 ),
//               ],
//             ),
//           ),
//           pollOptions: List<PollOption>.from(poll.option),
//           votedPercentageTextStyle: const TextStyle(
//             fontSize: 10,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }
// }
