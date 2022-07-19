import 'package:flutter/material.dart';
import 'package:flutter_polls/flutter_polls.dart';

class Poll {
  int id;
  String question;
  DateTime endDate;
  List<PollOption> option = [
    PollOption(title: const Text('За Залупу'), votes: 0, id: 1),
    PollOption(title: const Text('Проти Залупи'), votes: 0, id: 2),
    PollOption(title: const Text('Утримався від залупи'), votes: 0, id: 3)
  ];
  Poll({
    required this.id,
    required this.question,
    required this.endDate,
  });
}
