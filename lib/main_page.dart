import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'drawer_widget.dart';
import 'models/poll.dart';
import 'models/poll_data.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Provider.of<PollData>(context, listen: false).clicked == true) {
      Provider.of<PollData>(context, listen: false).clicked = false;
    }

    print('False');
    var pollsEmpty =
        Provider.of<PollData>(context, listen: false).polls.isEmpty;
    return Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Голосування Верховної Ради України',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
          ),
          // actions: [
          //   IconButton(
          //       onPressed: pollsEmpty
          //           ? () {
          //               Provider.of<PollData>(context, listen: false).addPoll(
          //                   Poll(
          //                       id: 0,
          //                       question: 'question',
          //                       startTime: TimeOfDay.now().hour,
          //                       startMinute: TimeOfDay.now().minute,
          //                       startTimestamp: Timestamp.now()));
          //             }
          //           : () {},
          //       icon: const Icon(Icons.add_circle_outlined))
          // ],
        ),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Color.fromARGB(255, 212, 140, 32)],
                ),
                image: DecorationImage(
                  image: AssetImage("assets/images/1.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ));
  }
}
