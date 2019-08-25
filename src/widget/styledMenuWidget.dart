import 'package:flutter/material.dart';

class StyledMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text('Football System'),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        ListTile(
          title: Text('registration'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            // Navigator.pushNamed(context, '/registration');
            Navigator.pushNamedAndRemoveUntil(
                context, '/registration', (_) => false);
          },
        ),
      ],
    );
  }
}
