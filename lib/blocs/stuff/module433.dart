import 'package:flutter/material.dart';

import 'package:football_system/custom_icon/soccerplayer_icons.dart';

class Module433 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Module433State();
  }
}

class Module433State extends State<Module433> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 9,
      children: List.generate(
        13 * 9,
        (index) => DragTarget(builder:
            (BuildContext context, List candidateData, List rejectedData) {
          return (index == 112 ||
                  index == 95 ||
                  index == 93 ||
                  index == 79 ||
                  index == 73 ||
                  index == 58 ||
                  index == 52 ||
                  index == 46 ||
                  index == 4 ||
                  index == 10 ||
                  index == 16)
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
