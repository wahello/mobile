import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum TypeAddForm { COACH, PLAYER, TEAM }

class AddFormSingle extends StatefulWidget {
  final TypeAddForm type;

  const AddFormSingle({Key key, @required this.type}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddFormSingleState();
  }
}

class AddFormSingleState extends State<AddFormSingle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('Name: '),
              TextField(
                maxLength: 100,
              )
            ],
          ),
          widget.type == TypeAddForm.PLAYER
              ? Row(
                  children: <Widget>[
                    Text('Number: '),
                    TextField(
                      maxLength: 100,
                    )
                  ],
                )
              : SizedBox.shrink(),
          widget.type == TypeAddForm.PLAYER
              ? Row(
                  children: <Widget>[
                    Text('Role: '),
                    TextField(
                      maxLength: 100,
                    )
                  ],
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
