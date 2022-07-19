import 'package:flutter/material.dart';
import 'package:rada_poll/add_poll.dart';
import 'package:rada_poll/archive.dart';
import 'package:rada_poll/poll_screen.dart';

import 'main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(),
        '/Archive': ((context) => ArchiveScreen()),
        '/Add': ((context) => AddPollScreen()),
        '/Poll': ((context) => PollScreen()),
      },
      title: 'Rada',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
