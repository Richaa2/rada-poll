import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rada_poll/models/poll.dart';

class PollData extends ChangeNotifier {
  List<Poll> polls = [
    Poll(
      id: 1,
      question: 'Якась залупа буде писатись',
      endDate: DateTime(2022, 9, 21),
      endTime: TimeOfDay(hour: 16, minute: 10),
      startDate: DateTime(2022, 8, 21),
      startTime: TimeOfDay(hour: 20, minute: 7),
      votedOrNo: false,
    ),
    Poll(
      id: 2,
      question: '2',
      endDate: DateTime(2022, 10, 22),
      endTime: TimeOfDay(hour: 22, minute: 1),
      startDate: DateTime(2022, 7, 21),
      startTime: TimeOfDay(hour: 4, minute: 9),
      votedOrNo: false,
    ),
    Poll(
        id: 3,
        question: 'now',
        endDate: DateTime(2022, 10, 22),
        endTime: TimeOfDay(hour: 22, minute: 1),
        startDate: DateTime.now(),
        startTime: TimeOfDay.now(),
        votedOrNo: false),
    Poll(
      id: 4,
      question: '4',
      endDate: DateTime(2022, 10, 22),
      endTime: TimeOfDay(hour: 22, minute: 1),
      startDate: DateTime(2022, 7, 21),
      startTime: TimeOfDay(hour: 4, minute: 9),
      votedOrNo: true,
    ),
  ];
  DateTime selectedTime = DateTime.now();
  TimeOfDay selectedTime2 = TimeOfDay.now();
  DateTime selectedTime3 = DateTime.now();
  TimeOfDay selectedTime4 = TimeOfDay.now();

  void changeDate(DateTime selectedTime, DateTime newSelectedTime) {
    selectedTime = newSelectedTime;
    notifyListeners();
  }

  void changeTime(TimeOfDay selectedTime, TimeOfDay newSelectedTime) {
    selectedTime = newSelectedTime;
    notifyListeners();
  }

  void createPoll(Poll poll) {
    polls.add(Poll(
        id: poll.id,
        question: poll.question,
        endDate: poll.endDate,
        endTime: poll.endTime,
        startDate: poll.startDate,
        startTime: poll.startTime,
        votedOrNo: false));
    notifyListeners();
  }

  void changeDecision(Poll poll) {
    poll.changeDecision();
    notifyListeners();
  }
}
