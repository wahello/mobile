import 'package:flutter/material.dart';

class Module433 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Module433State();
  }
}

class Module433State extends State<Module433> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
              ? Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ))
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
