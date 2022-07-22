import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:rada_poll/poll_screen.dart';

// TODO slive disable
class LoginScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
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
              Container(
                width: 100,
                height: 30,
                child: TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  controller: _controller,
                  onChanged: (inputCode) {
                    code = inputCode;
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (code.contains('12')) {
                      try {
                        final existUser =
                            await _auth.signInWithEmailAndPassword(
                                email: 'admin@gmail.com', password: '123456');
                        if (existUser != null) {
                          Navigator.pushNamed(context, '/');
                        }
                      } catch (e) {
                        print(e);
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PollScreen(
                                    indexOfPoll: 0,
                                  )));
                    }
                    if (code.contains('111')) {
                      try {
                        final existUser =
                            await _auth.signInWithEmailAndPassword(
                                email: '1@gmail.com', password: '123456');
                        if (existUser != null) {
                          Navigator.pushNamed(context, '/');
                        }
                      } catch (e) {
                        print(e);
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PollScreen(
                                    indexOfPoll: indexOfPoll,
                                  )));
                    }
                    if (code.contains('222')) {
                      try {
                        final existUser =
                            await _auth.signInWithEmailAndPassword(
                                email: '2@gmail.com', password: '123456');
                        if (existUser != null) {
                          Navigator.pushNamed(context, '/');
                        }
                      } catch (e) {
                        print(e);
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PollScreen(
                                    indexOfPoll: 1,
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
