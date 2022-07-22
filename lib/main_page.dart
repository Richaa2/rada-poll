import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'drawer_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // dispose();
    return Scaffold(
        drawer: DrawerWidget(),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Poll rada'),
        ),
        body: Container(
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Color.fromARGB(255, 212, 140, 32)],
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/images/1.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Center()
            ],
          ),
        ));
  }
}
