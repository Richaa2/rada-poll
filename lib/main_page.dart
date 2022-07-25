
import 'package:flutter/material.dart';


import 'drawer_widget.dart';


class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Голосування Верховної Ради України',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
          ),
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
