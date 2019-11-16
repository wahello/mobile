import 'package:flutter/material.dart';

class FootballField extends StatefulWidget {
  FootballField({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FootballFieldState createState() => _FootballFieldState();
}

class _FootballFieldState extends State<FootballField> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/A1QA94rgGUL._AC_SY879_.jpg'))),
          child: Container(
              margin: EdgeInsets.only(top: 180),
              padding: EdgeInsets.all(25),
              child: Stack(
                children: <Widget>[
                  GridView.count(
                    crossAxisCount: 9,
                    children: List.generate(
                      8 * 9,
                      (_) => DragTarget(builder: (BuildContext context,
                          List candidateData, List rejectedData) {
                        return Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.rectangle,
                            ));
                      }),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 250),
                    child: Center(
                      child: DragTarget(builder: (BuildContext context,
                          List candidateData, List rejectedData) {
                        return Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.rectangle,
                            ));
                      }),
                    ),
                  ),
                ],
              ))),
    ));
  }
}
