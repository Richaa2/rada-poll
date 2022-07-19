import 'package:flutter_polls/flutter_polls.dart';

class Poll {
  int id;
  String question;
  DateTime endDate;
  List<PollOption> option;
  Poll({
    required this.id,
    required this.question,
    required this.endDate,
    required this.option,
  });
}
