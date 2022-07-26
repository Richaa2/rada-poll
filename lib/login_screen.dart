import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:rada_poll/models/poll_data.dart';

import 'package:rada_poll/poll_screen.dart';

// TODO slive disable
class LoginScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  final int? indexOfPoll;
  final String iid;
  LoginScreen({Key? key, this.indexOfPoll, required this.iid})
      : super(key: key);
  final TextEditingController _controller = TextEditingController();

  var currectCodes = {
    'admin@gmail.com': '17159881',
    '1@gmail.com': '17151327',
    '2@gmail.com': '17151488',
    '3@gmail.com': '17152060',
    '4@gmail.com': '17154513',
  };
  // '17159881',
  // '17151327',
  // '17151488',
  // '17152060',
  // '17154513',

  void LoginVer(
      final AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
      final String inputCode,
      final FirebaseAuth _auth,
      final String iid,
      BuildContext context) async {
    if (currectCodes.values.any((element) => element == inputCode)) {
      var mapEmail = currectCodes.entries
          .firstWhere((element) => element.value == inputCode)
          .key;

      try {
        final existUser = await _auth.signInWithEmailAndPassword(
            email: mapEmail, password: '123456');
      } catch (e) {
        print(e);
      }
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(
      //         builder: (context) => PollScreen(
      //             indexOfPoll: indexOfPoll)),
      //     (Route<dynamic> route) => false);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => PollScreen(
                    indexOfPoll: iid,
                  )));

      var users = snapshot.data!.docs
          .firstWhere((element) => element.id == '1')
          .get('amount');
      var data;
      if (users >= 5) {
        data = {'amount': 5};
      } else {
        data = {'amount': users + 1};
      }

      FirebaseFirestore.instance.collection('users').doc('1').update(data);
      print(users);

      Provider.of<PollData>(context, listen: false).haveOrNo = false;
    }
  }

  String inputCode = '';

  // bool currectCode = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Веритифікація'),
                centerTitle: true,
              ),
              body: Container(
                decoration: const BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.blue, Color.fromARGB(255, 212, 140, 32)],
                  ),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    physics: const ScrollPhysics(
                        parent: const AlwaysScrollableScrollPhysics()),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Веддіть код ',
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          Container(
                            width: 100,
                            height: 30,
                            child: TextFormField(
                              style: const TextStyle(color: Colors.white),
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
                                FirebaseFirestore.instance
                                    .collection('waitOrClickOrStart')
                                    .doc('1')
                                    .update({'waitOrClickOrStart': 2});
                                LoginVer(
                                    snapshot, inputCode, _auth, iid, context);
                              },
                              child: const Text('Нажміть'))
                        ]),
                  ),
                ),
              ),
            );
          }
          return Container();
        });
  }

  // Login(
  //   inputCode: code,
  //   auth: _auth,
  //   iid: iid,
  //   currectCode: '17159881',
  //   snapshot: snapshot,
  //   userEmail: 'admin@gmail.com',
  // ),
  // Login(
  //     inputCode: code,
  //     auth: _auth,
  //     iid: iid,
  //     snapshot: snapshot,
  //     currectCode: '17151327',
  //     userEmail: '1@gmail.com'),
  // Login(
  //     inputCode: code,
  //     auth: _auth,
  //     iid: iid,
  //     snapshot: snapshot,
  //     currectCode: '17151488',
  //     userEmail: '2@gmail.com'),
  // Login(
  //     inputCode: code,
  //     auth: _auth,
  //     iid: iid,
  //     snapshot: snapshot,
  //     currectCode: '17152060',
  //     userEmail: '3@gmail.com'),
  // Login(
  //     inputCode: code,
  //     auth: _auth,
  //     iid: iid,
  //     snapshot: snapshot,
  //     currectCode: '17154513',
  //     userEmail: '4@gmail.com'
}
