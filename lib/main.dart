import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rada_poll/add_poll.dart';
import 'package:rada_poll/archive.dart';
import 'package:rada_poll/models/poll_data.dart';
import 'package:rada_poll/poll_screen.dart';
import 'package:rada_poll/select_poll.dart';
import 'package:rada_poll/test_screen.dart';

import 'login_screen.dart';
import 'main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
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
              // '/': (context) => PollScreen(
              //       indexOfPoll: 2,
              //     ),
              '/': (context) => MainPage(),
              '/Archive': ((context) => ArchiveScreen()),
              '/Add': ((context) => AddPollScreen()),
              // '/Poll': ((context) => PollScreen(indexOfPoll: null,)),
              '/SelectPoll': ((context) => SelectPoll())
            },
            title: 'Rada',
            theme: ThemeData(scaffoldBackgroundColor: Colors.blue),
          );
        });
  }
}
