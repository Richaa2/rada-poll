import 'package:cloud_firestore/cloud_firestore.dart';


class Poll {
  int id;
  String question;
  // int endDate = DateTime(
  //         DateTime.now().year, DateTime.now().month, DateTime.now().day + 1)
  //     .millisecondsSinceEpoch;
  // int endTime = TimeOfDay(hour: 0, minute: 0).hour;
  Timestamp startTimestamp;
  // int startDate;
  int startTime;
  bool votedOrNo;
  bool decision;

  // List<PollOption> option = [
  //   PollOption(
  //       title: Container(
  //           height: 30,
  //           width: 300,
  //           color: Colors.green,
  //           child: const Center(child: Text('За Залупу'))),
  //       votes: 0,
  //       id: 1),
  //   PollOption(
  //       title: Container(
  //           height: 30,
  //           width: 300,
  //           color: Colors.red,
  //           child: const Center(child: Text('Проти Залупи'))),
  //       votes: 0,
  //       id: 2),
  //   PollOption(
  //       title: Container(
  //           height: 30,
  //           width: 300,
  //           color: Colors.grey,
  //           child: const Center(child: Text('Утримався від залупи'))),
  //       votes: 0,
  //       id: 3)
  // ];
  int startMinute;
  int yes;
  int no;
  int hold;
  int didNotVote;
  Poll({
    required this.id,
    required this.question,
    // required this.endDate,
    // required this.endTime,
    // required this.startDate,
    required this.startTime,
    this.votedOrNo = false,
    this.decision = false,
    required this.startMinute,
    required this.startTimestamp,
    this.hold = 0,
    this.yes = 0,
    this.didNotVote = 0,
    this.no = 0,
  });

  void changeDecision() {
    decision = true;
  }
}
