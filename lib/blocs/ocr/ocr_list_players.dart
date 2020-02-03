import 'package:flutter/cupertino.dart';

class OcrListPlayers extends StatefulWidget {
  final List<String> playersToShow;

  const OcrListPlayers({Key key, @required this.playersToShow})
      : super(key: key);

  @override
  OcrListPlayerState createState() {
    return OcrListPlayerState();
  }
}

class OcrListPlayerState extends State<OcrListPlayers> {
  ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    if (widget.playersToShow.length > 0) {
      return Container(
        child: ListView.builder(
            controller: _scrollController,
            itemCount: widget.playersToShow.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext ctxt, int index) {
              String name = widget.playersToShow[index].toString();
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(name),
                ],
              );
            }),
      );
    } else {
      return Container();
    }
  }
}
