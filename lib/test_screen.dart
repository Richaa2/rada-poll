import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:rada_poll/models/poll_data.dart';
import 'package:rada_poll/poll_screen.dart';

class TestScreen extends StatelessWidget {
  TestScreen({Key? key, required this.index}) : super(key: key);
  String index;

  @override
  Widget build(BuildContext context) {
    print(index.toString() + 'index on final');
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("poll")
            .orderBy('id')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var question = snapshot.data!.docs
                .firstWhere((element) => element.id == index)
                .get('question');

            return ModalProgressHUD(
              inAsyncCall: startedPoll,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text('Rich'),
                      AnimatedContainer(
                        duration: Duration(seconds: 10),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            image: DecorationImage(
                                image: AssetImage('assets/images/3.jpg'),
                                fit: BoxFit.fill)),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade700,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50))),
                              height: 100,
                              child: Center(
                                child: Text(
                                  'Рада IV',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 2000,
                        height: 4,
                        color: Colors.black,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.grey.shade700,
                              height: 300,
                              child: Row(
                                children: [
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'ЗА',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            Provider.of<PollData>(context,
                                                    listen: false)
                                                .clickYes += 1;

                                            // var id = snapshot2.data!.docs[index].id;
                                            var yesOld = snapshot.data!.docs
                                                .firstWhere((element) =>
                                                    element.id == index)
                                                .get('yes');
                                            var data = {'yes': yesOld + 1};
                                            FirebaseFirestore.instance
                                                .collection('poll')
                                                .doc(index)
                                                .update(data);
                                            print('click' +
                                                Provider.of<PollData>(context,
                                                        listen: false)
                                                    .clickYes
                                                    .toString());
                                            startedPoll = true;
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    spreadRadius: 3,
                                                    blurRadius: 3,
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                                border: Border.all(width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(200),
                                                color: Colors.green),
                                            width: 70,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'УТРИМАВСЯ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            Provider.of<PollData>(context,
                                                    listen: false)
                                                .clickHold += 1;
                                            snapshot.data!.docs.sort(
                                              (a, b) => b.id.compareTo(a.id),
                                            );
                                            var holdOld = snapshot.data!.docs
                                                .firstWhere((element) =>
                                                    element.id == index)
                                                .get('hold');
                                            var data = {'hold': holdOld + 1};
                                            FirebaseFirestore.instance
                                                .collection('poll')
                                                .doc(index)
                                                .update(data);
                                            print('click' +
                                                Provider.of<PollData>(context,
                                                        listen: false)
                                                    .clickHold
                                                    .toString());
                                            startedPoll = true;
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    spreadRadius: 3,
                                                    blurRadius: 3,
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                                border: Border.all(width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(200),
                                                color: Colors.amber),
                                            width: 70,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'ПРОТИ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            var noOld = snapshot.data!.docs
                                                .firstWhere((element) =>
                                                    element.id == index)
                                                .get('no');
                                            var data = {'no': noOld + 1};
                                            FirebaseFirestore.instance
                                                .collection('poll')
                                                .doc(index)
                                                .update(data);
                                            print('click' +
                                                Provider.of<PollData>(context,
                                                        listen: false)
                                                    .clickNo
                                                    .toString());
                                            startedPoll = true;
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  spreadRadius: 3,
                                                  blurRadius: 3,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                              border: Border.all(width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(200),
                                              color: Colors.red,
                                            ),
                                            width: 70,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 2000,
                        height: 4,
                        color: Colors.black,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade700,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(100),
                                        bottomRight: Radius.circular(100))),
                                height: 150,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Spacer(
                                      flex: 1,
                                    ),
                                    Column(
                                      children: [
                                        Spacer(
                                          flex: 1,
                                        ),
                                        Text(
                                          'ЗАПИС НА ВИСТУП',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Spacer(
                                          flex: 1,
                                        ),
                                        Flexible(
                                          flex: 10,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                  spreadRadius: 1,
                                                  blurRadius: 1,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                              border: Border.all(width: 2),
                                              color: Colors.grey.shade900,
                                            ),
                                            width: 70,
                                          ),
                                        ),
                                        Spacer(
                                          flex: 1,
                                        ),
                                      ],
                                    ),
                                    Spacer(
                                      flex: 1,
                                    ),
                                    Column(
                                      children: [
                                        Spacer(
                                          flex: 1,
                                        ),
                                        Text(
                                          'ВІДМОВА ВІД ВИСТУПУ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Spacer(
                                          flex: 1,
                                        ),
                                        Flexible(
                                          flex: 10,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                  spreadRadius: 1,
                                                  blurRadius: 1,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                              border: Border.all(width: 2),
                                              color: Colors.grey.shade900,
                                            ),
                                            width: 70,
                                          ),
                                        ),
                                        Spacer(
                                          flex: 1,
                                        ),
                                      ],
                                    ),
                                    Spacer(
                                      flex: 1,
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        });
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.green[800]!;
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, size.height * 0.25);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2, size.width, size.height * 0.25);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
