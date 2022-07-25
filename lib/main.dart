import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rada_poll/add_poll.dart';
import 'package:rada_poll/archive.dart';
import 'package:rada_poll/models/poll_data.dart';

import 'package:rada_poll/select_poll.dart';

import 'firebase_options.dart';

import 'main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => const MainPage(),
              // '/': (context) => PollScreen(indexOfPoll: '5EiELmmP7rQqICUZovLJ'),
              '/Archive': ((context) => const ArchiveScreen()),
              '/Add': ((context) => const AddPollScreen()),
              // '/Poll': ((context) => PollScreen(indexOfPoll: null,)),
              '/SelectPoll': ((context) => const SelectPoll())
            },
            title: 'Rada',
            theme: ThemeData(scaffoldBackgroundColor: Colors.blue),
          );
        });
  }
}
