import 'package:flutter/foundation.dart';
import 'package:rada_poll/models/poll.dart';

class PollData extends ChangeNotifier {
  List<Poll> polls = [
    Poll(
      id: 1,
      question: 'Якась залупа буде писатись',
      endDate: DateTime(2022, 9, 21),
    ),
    Poll(
      id: 2,
      question: 'Якась залупа буде писатись',
      endDate: DateTime(2022, 10, 22),
    )
  ];
}
