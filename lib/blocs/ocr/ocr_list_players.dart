import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

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

  void changePlayer(String newValue, int index) {
    widget.playersToShow[index] = newValue;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.playersToShow.length > 0) {
      return SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: <Widget>[
              Text('Giocatori da inserire',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
              ListView.builder(
                  primary: false,
                  controller: _scrollController,
                  itemCount: widget.playersToShow.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext ctxt, int index) {
                    String name = widget.playersToShow[index].toString();
                    return TextFormField(
                      initialValue: name ?? '',
                      onChanged: (newValue) {
                        changePlayer(newValue, index);
                      },
                    );
                  }),
              StyledButtonWidget(
                hint: 'Submit',
                onPressed: () {
                  print('Premuto bottono di submit');
                },
              )
            ],
          ));
    } else {
      return Container();
    }
  }
}
