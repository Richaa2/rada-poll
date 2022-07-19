import 'package:flutter/cupertino.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:rada_poll/models/poll.dart';

List<Poll> polls2 = [
  Poll(
    id: 1,
    question: 'Якась залупа буде писатись',
    endDate: DateTime(2022, 9, 21),
    option: [
      PollOption(
          id: 1, title: Text('небуде ніхуя писатись я сказав'), votes: 5),
      PollOption(id: 2, title: Text(' писатись я сказав'), votes: 2),
      PollOption(id: 3, title: Text('Пішов нахуй'), votes: 1),
      PollOption(id: 4, title: Text('Залупа'), votes: 0),
    ],
  ),
  Poll(
    id: 2,
    question: 'Якась залупа буде писатись',
    endDate: DateTime(2022, 10, 22),
    option: [
      PollOption(
          id: 1, title: Text('небуде ніхуя писатись я сказав'), votes: 5),
      PollOption(id: 2, title: Text(' писатись я сказав'), votes: 2),
      PollOption(id: 3, title: Text('Пішов нахуй'), votes: 1),
      PollOption(id: 4, title: Text('Залупа'), votes: 0),
    ],
  )
];
