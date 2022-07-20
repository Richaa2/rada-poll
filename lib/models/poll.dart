import 'package:flutter/material.dart';
import 'package:flutter_polls/flutter_polls.dart';

class Poll {
  int id;
  String question;
  DateTime endDate = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
  TimeOfDay endTime = TimeOfDay(hour: 0, minute: 0);
  DateTime startDate;
  TimeOfDay startTime;
  bool votedOrNo;
  bool decision;
  List<PollOption> option = [
    PollOption(
        title: Container(
            height: 30,
            width: 300,
            color: Colors.green,
            child: const Center(child: Text('За Залупу'))),
        votes: 0,
        id: 1),
    PollOption(
        title: Container(
            height: 30,
            width: 300,
            color: Colors.red,
            child: const Center(child: Text('Проти Залупи'))),
        votes: 0,
        id: 2),
    PollOption(
        title: Container(
            height: 30,
            width: 300,
            color: Colors.grey,
            child: const Center(child: Text('Утримався від залупи'))),
        votes: 0,
        id: 3)
  ];
  Poll(
      {required this.id,
      required this.question,
      required this.endDate,
      required this.endTime,
      required this.startDate,
      required this.startTime,
      this.votedOrNo = false,
      this.decision = false});

  void changeDecision() {
    decision = true;
  }
}
