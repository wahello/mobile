import 'package:flutter/material.dart';

import 'module433.dart';
import 'module442.dart';

class FootballField extends StatefulWidget {
  String formazione;

  FootballField({this.formazione});

  @override
  _FootballFieldState createState() {
    return _FootballFieldState();
  }
}

class _FootballFieldState extends State<FootballField> {
  Widget module;

  @override
  Widget build(BuildContext context) {
    if (widget.formazione == '4-4-2') {
      module = Module442();
    } else if (widget.formazione == '4-3-3') {
      module = Module433();
    }
    return Scaffold(
        body: Center(
            child: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/A1QA94rgGUL._AC_SY879_.jpg'))),
      child: Container(
        margin: EdgeInsets.only(top: 50),
        padding: EdgeInsets.all(25),
        child: module,
      ),
    )));
  }
}
