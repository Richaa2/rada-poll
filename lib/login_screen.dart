import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:rada_poll/poll_screen.dart';

// TODO slive disable
class LoginScreen extends StatelessWidget {
  final int indexOfPoll;
  LoginScreen({
    Key? key,
    required this.indexOfPoll,
  }) : super(key: key);
  TextEditingController _controller = TextEditingController();
  String code = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Веритифікація'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Color.fromARGB(255, 212, 140, 32)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            physics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Веддіть код '),
              TextFormField(
                controller: _controller,
                onChanged: (inputCode) {
                  code = inputCode;
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    if (code.contains('12')) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PollScreen(
                                    indexOfPoll: indexOfPoll,
                                  )));
                    }
                  },
                  child: Text('Click'))
            ]),
          ),
        ),
      ),
    );
  }
}
