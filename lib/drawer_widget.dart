import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [
          drawer_tile(
            text: 'перейти до голосування',
            routeName: '/SelectPoll',
          ),
          drawer_tile(
            text: 'зробити голосування',
            routeName: '/Add',
          ),
          drawer_tile(
            text: 'перейти до архіву',
            routeName: '/Archive',
          ),
        ],
      ),
    );
  }
}

class drawer_tile extends StatelessWidget {
  final String text;
  final String routeName;
  const drawer_tile({
    Key? key,
    required this.text,
    required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text),
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
    );
  }
}
