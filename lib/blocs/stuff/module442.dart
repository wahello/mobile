import 'package:flutter/material.dart';
import 'package:footballfield/custom_icon/soccerplayer_icons.dart';

import 'field.dart';

class Module442 extends StatefulWidget {
  final Field posizioni = Field();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Module442State();
  }
}

class Module442State extends State<Module442> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView.count(
      crossAxisCount: 9,
      children: List.generate(
        13 * 9,
        (index) => DragTarget(builder:
            (BuildContext context, List candidateData, List rejectedData) {
          return (index == 11 ||
                  index == 15 ||
                  index == 57 ||
                  index == 59 ||
                  index == 37 ||
                  index == 43 ||
                  index == 95 ||
                  index == 93 || //=> posizioni[]
                  index == 79 || //=> posizioni[8][7]
                  index == 73 || //=> posizioni[8][1]
                  index == 112) //=> posizioni[12][4]
              ? Draggable(
                  child: Icon(
                    Soccerplayer.soccer_player,
                    size: 40,
                  ),
                  feedback: Icon(
                    Soccerplayer.soccer_player,
                    size: 40,
                  ),
                  childWhenDragging: Icon(
                    Soccerplayer.soccer_player,
                    size: 40,
                  ),
                )
              : Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.rectangle,
                  ));
        }),
      ),
    );
  }
}
