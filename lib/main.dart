import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rada_poll/add_poll.dart';
import 'package:rada_poll/archive.dart';
import 'package:rada_poll/models/poll_data.dart';
import 'package:rada_poll/poll_screen.dart';
import 'package:rada_poll/select_poll.dart';

import 'main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => PollData(),
        builder: (context, child) {
          return MaterialApp(
            initialRoute: '/',
            routes: {
              '/': (context) => MainPage(),
              '/Archive': ((context) => ArchiveScreen()),
              '/Add': ((context) => AddPollScreen()),
              // '/Poll': ((context) => PollScreen(indexOfPoll: null,)),
              '/SelectPoll': ((context) => SelectPoll())
            },
            title: 'Rada',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
          );
        });
  }
}
