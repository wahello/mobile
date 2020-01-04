import 'package:flutter/material.dart';
import 'package:football_system/blocs/footballField/FootballFieldBloc.dart';
import 'package:football_system/blocs/footballField/FootballFieldEvent.dart';
import 'package:football_system/blocs/footballField/FootballFieldState.dart';
import 'package:football_system/blocs/stuff/event.dart';
import 'package:football_system/blocs/stuff/note.dart';
import 'package:football_system/custom_icon/soccer_icons_icons.dart';
import 'package:shared/shared.dart';

class OptionsScreen extends StatefulWidget {
  FootballFieldBloc footbalFieldBloc;

  OptionsScreen({this.footbalFieldBloc});
  @override
  _OptionsScreenState createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  FootballFieldBloc footbalFieldBloc;
  TextEditingController _noteFieldController;
  var _tapIndex;

  _OptionsScreenState({this.footbalFieldBloc});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: <Widget>[
          FlatButton(
              onPressed: openAlertBox,
              child: Center(
                  child: Row(
                children: <Widget>[
                  Text('Add note'),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  ),
                  Icon(Icons.note_add)
                ],
              ))),
          FlatButton(
              onPressed: () {
                _showEventMenu(footbalFieldBloc.currentPlayer);
              },
              child: Center(
                  child: Row(
                children: <Widget>[
                  Text('Events'),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  ),
                  Icon(Icons.shuffle)
                ],
              ))),
          FlatButton(
              onPressed: () {
                footbalFieldBloc.add(RemoveFootballPlayerFromField(
                    footbalFieldBloc
                        .addedPlayers[footbalFieldBloc.currentPlayer]));
              },
              child: Center(
                  child: Row(
                children: <Widget>[
                  Text('Remove'),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  ),
                  Icon(Icons.delete)
                ],
              )))
        ],
      ),
    ));
  }

  void _showEventMenu(int index) {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            child: Column(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    addEvent(footbalFieldBloc.addedPlayers[index].id,
                        EventType.yellowCard, 0); //TODO recuperare istantaneaID
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        SoccerIcons.yellowCard,
                        color: Colors.yellow,
                      ),
                      Text('Cartellino Giallo')
                    ],
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    addEvent(footbalFieldBloc.addedPlayers[index].id,
                        EventType.redCard, 0); //TODO recuperare istantaneaID
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        SoccerIcons.redCard,
                        color: Colors.red,
                      ),
                      Text('Cartellino Rosso')
                    ],
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    addEvent(footbalFieldBloc.addedPlayers[index].id,
                        EventType.goal, 0); //TODO recuperare istantaneaID
                  },
                  child: Row(
                    children: <Widget>[Icon(SoccerIcons.goal), Text('Goal')],
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    addEvent(
                        footbalFieldBloc.addedPlayers[index].id,
                        EventType.substitution,
                        0); //TODO recuperare istantaneaID
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(SoccerIcons.substitution),
                      Text('Substituion')
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  void addEvent(int playerId, EventType type, int instId) {
    //TODO recuperare lista eventi da incontro
    Event(playerId, type, instId);
    //TODO aggiungere alla lista
  }

  openAlertBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Player's note",
                          style: TextStyle(fontSize: 24.0),
                        )
                      ]),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Add note",
                        border: InputBorder.none,
                      ),
                      maxLines: 8,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      saveNote(_noteFieldController.text,
                          footbalFieldBloc.addedPlayers[_tapIndex].id);
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: Text(
                        "Confirm note",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void saveNote(String note, playerId) {
    //TODO recuperare lista note da incontro
    Note(playerId, note);
    //TODO aggiungere alla lista
  }
}
