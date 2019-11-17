import 'package:flutter/material.dart';

class Module442 extends StatefulWidget {
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
                  index == 93 ||
                  index == 79 ||
                  index == 73 ||
                  index == 112)
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
