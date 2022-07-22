import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rada_poll/models/poll.dart';

class PollData extends ChangeNotifier {
  int waitOrClickOrStart = 1;
  int clickYes = 0;
  int clickNo = 0;
  int clickHold = 0;
  int seconds2 = 5;

  List<Poll> polls = [
    // Poll(
    //   id: 1,
    //   question: 'Якась залупа буде писатись',
    //   endDate: DateTime(2022, 9, 21).millisecondsSinceEpoch,
    //   endTime: TimeOfDay(hour: 16, minute: 10).hour,
    //   startTimestamp: Timestamp.now(),
    //   startTime: TimeOfDay.now().hour,
    //   votedOrNo: false,
    //   startMinute: TimeOfDay.now().minute,
    // ),
    // Poll(
    //   id: 2,
    //   question: '2',
    //   endDate: DateTime(2022, 10, 22),
    //   endTime: TimeOfDay(hour: 22, minute: 1),
    //   startDate: DateTime(2022, 7, 21),
    //   startTime: TimeOfDay(hour: 4, minute: 9),
    //   votedOrNo: false,
    // ),
    // Poll(
    //     id: 3,
    //     question: 'now',
    //     endDate: DateTime(2022, 10, 22),
    //     endTime: TimeOfDay(hour: 22, minute: 1),
    //     startDate: DateTime.now(),
    //     startTime: TimeOfDay.now(),
    //     votedOrNo: false),
    // Poll(
    //   id: 4,
    //   question: '4',
    //   endDate: DateTime(2022, 10, 22),
    //   endTime: TimeOfDay(hour: 22, minute: 1),
    //   startDate: DateTime(2022, 7, 21),
    //   startTime: TimeOfDay(hour: 4, minute: 9),
    //   votedOrNo: true,
    // ),
  ];
  // ..sort(
  //     (a, b) => b.id.compareTo(a.id),
  //   );
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

  int indexOf = 0;
  void wtf() {
    if (polls.any((element) =>
        element.startTimestamp.toDate().day == DateTime.now().day &&
        element.startTime == TimeOfDay.now().hour &&
        element.startMinute == TimeOfDay.now().minute &&
        element.votedOrNo == false)) {
      print('lol');
      var lol = polls.indexWhere((element) =>
          element.startTimestamp.toDate().day == DateTime.now().day &&
          element.startTime == TimeOfDay.now().hour &&
          element.startMinute == TimeOfDay.now().minute &&
          element.votedOrNo == false);
      print('index' + lol.toString());
      indexOf = lol;

      // selectedPoll = pollsFire.indexWhere((element) =>
      //     element.get('w') == Timestamp.fromDate(DateTime.now()) &&
      //     element.get('startTime') == TimeOfDay.now().hour &&
      //     element.get('startMinute') == TimeOfDay.now().minute &&
      //     element.get('votedOrNo') == false);

    }
  }

  // void createPoll(Poll poll) {
  //   polls.add(Poll(
  //       id: poll.id,
  //       question: poll.question,
  //       endDate: poll.endDate,
  //       endTime: poll.endTime,
  //       // startDate: poll.startDate,
  //       startTime: poll.startTime,
  //       votedOrNo: false,
  //       startMinute: poll.startMinute,
  //       startTimestamp: poll.startTimestamp));
  //   notifyListeners();
  // }

  void changeDecision(Poll poll) {
    poll.changeDecision();
    notifyListeners();
  }

  void addPoll(Poll poll) {
    FirebaseFirestore.instance.collection('poll').add({
      "decision": poll.decision,
      "endDate": poll.endDate,
      "endTime": poll.endTime,
      "id": polls.length + 1,
      "question": poll.question,
      "w": poll.startTimestamp,
      "startMinute": poll.startMinute,
      "votedOrNo": poll.votedOrNo,
      "startTime": poll.startTime,
      "yes": poll.yes,
      "no": poll.no,
      "hold": poll.hold,
      "didNotVote": poll.didNotVote,
    });

    polls.add(poll);

    notifyListeners();
  } // "startDate": poll.startDate,
  // "startTime": poll.startTime,

  void updateWait() {
    final data = {'waitOrClickOrStart': 2};
    FirebaseFirestore.instance
        .collection('waitOrClickOrStart')
        .doc('1')
        .update(data);
    waitOrClickOrStart = 2;

    notifyListeners();
  }

  void addVote(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot2, int index, int click) {
    var id = snapshot2.data!.docs[index].id;

    FirebaseFirestore.instance
        .collection('poll')
        .doc(id)
        .update({'yes': click});
  }
}
