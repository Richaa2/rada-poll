import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'dialog_for_add.dart';
import 'models/poll.dart';
import 'models/poll_data.dart';

class LoginForAdd extends StatefulWidget {
  const LoginForAdd({Key? key}) : super(key: key);

  @override
  State<LoginForAdd> createState() => _LoginForAddState();
}

class _LoginForAddState extends State<LoginForAdd> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  String inputCode = '';

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 180,
      ),
      child: SingleChildScrollView(
        child: AlertDialog(
            title: const Center(
                child: Text(
              'Секретний пароль',
              style: TextStyle(fontWeight: FontWeight.w600),
            )),
            content: (SizedBox(
              child: Column(children: [
                Container(
                  width: 100,
                  height: 30,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    controller: _controller,
                    onChanged: (innputCode) {
                      inputCode = innputCode;
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (inputCode == '12062002') {
                        showDialog(
                            context: context,
                            builder: (context) => const DialogForAdd());
                      }
                    },
                    child: const Text('Нажміть'))
              ]),
            ))),
      ),
    );
  }
}
