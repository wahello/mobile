import 'package:flutter/material.dart';

import 'module433.dart';
import 'module442.dart';

class FootballField extends StatefulWidget {
  String formazione;
  double lato;

  FootballField({this.formazione, @required this.lato});

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
      module = Module442(
        lato: 30,
      );
    } else if (widget.formazione == '4-3-3') {
      module = Module433();
    }
    return Scaffold(
        body: Center(
            child: Container(
                child: Container(
                    constraints: BoxConstraints(
                        maxHeight: widget.lato * 10,
                        maxWidth: widget.lato * 21),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.scaleDown,
                            image: AssetImage(
                                'assets/A1QA94rgGUL._AC_SY879_.jpg'))),
                    child: module))));
  }
}
