import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_system/blocs/footballField/FootballFieldBloc.dart';
import 'package:football_system/blocs/footballField/FootballFieldState.dart';
import 'package:football_system/blocs/model/player_model.dart';
import 'package:football_system/custom_icon/soccerplayer_icons.dart';

import 'field.dart';

class Module442 extends StatefulWidget {
  final double lato;
  final Field posizioni = Field();
  final List<Player> players = new List(11);

  Module442({Key key, @required this.lato}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return Module442State();
  }
}

class Module442State extends State<Module442> {
  var _tapPosition;

// Passo come parametro il giocatore selezionato
  void _showCustomMenu() {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();

    showMenu(
            context: context,
            items: <PopupMenuEntry<int>>[PlayerMenu()],
            position: RelativeRect.fromRect(
                _tapPosition & Size(40, 40), // smaller rect, the touch area
                Offset.zero & overlay.size // Bigger rect, the entire screen
                ))
        // This is how you handle user selection
        .then<void>((int delta) {});
  }

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FootballFieldBloc, FootballFieldState>(
        bloc: FootballFieldBloc(),
        builder: (BuildContext context, FootballFieldState state) {
          return Container(
              child: GridView.count(
                  padding: EdgeInsets.all(0),
                  crossAxisSpacing: 12,
                  crossAxisCount: 9,
                  children: List.generate(
                      13 * 9,
                      (index) => (index == 11 ||
                              index == 15 ||
                              index == 57 ||
                              index == 59 ||
                              index == 37 ||
                              index == 43 ||
                              index == 95 ||
                              index == 93 || //=> posizioni[]
                              index == 79 || //=> posizioni[8][7]
                              index == 73 || //=> posizioni[8][1]
                              index == 112)
                          ? state is FootballFieldInitiated
                              ? GestureDetector(
                                  // This does not give the tap position ...
                                  onLongPress: _showCustomMenu,
                                  onTapDown: _storePosition,
                                  child: Container(
                                    child: Icon(
                                      Soccerplayer.soccer_player,
                                      size: widget.lato,
                                    ),
                                  ))
                              : state is FootballFieldCreated
                                  ? GestureDetector(
                                      // This does not give the tap position ...
                                      onLongPress: _showCustomMenu,
                                      onTapDown: _storePosition,
                                      child: Container(
                                        child: Icon(
                                          Soccerplayer.soccer_player,
                                          size: widget.lato,
                                        ),
                                      ))
                                  : state is FootballFieldEdit
                                      ? DragTarget(builder:
                                          (BuildContext context,
                                              List candidateData,
                                              List rejectedData) {
                                          return (index == 11 ||
                                                  index == 15 ||
                                                  index == 57 ||
                                                  index == 59 ||
                                                  index == 37 ||
                                                  index == 43 ||
                                                  index == 95 ||
                                                  index ==
                                                      93 || //=> posizioni[]
                                                  index ==
                                                      79 || //=> posizioni[8][7]
                                                  index ==
                                                      73 || //=> posizioni[8][1]
                                                  index ==
                                                      112) //=> posizioni[12][4]
                                              ? Draggable(
                                                  child: Icon(
                                                    Soccerplayer.soccer_player,
                                                    size: widget.lato,
                                                  ),
                                                  feedback: Icon(
                                                    Soccerplayer.soccer_player,
                                                    size: widget.lato,
                                                  ),
                                                  childWhenDragging: Icon(
                                                    Soccerplayer.soccer_player,
                                                    size: widget.lato,
                                                  ),
                                                )
                                              : Container(
                                                  decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  shape: BoxShape.rectangle,
                                                ));
                                        })
                                      : Container(
                                          decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          shape: BoxShape.rectangle,
                                        ))
                          : Container(
                              decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.rectangle,
                            )))));
        });
  }
}

class PlayerMenu extends PopupMenuEntry<int> {
  @override
  double height = 100;
  // height doesn't matter, as long as we are not giving
  // initialValue to showMenu().

  @override
  bool represents(int n) => n == 1 || n == -1;

  @override
  PlayerMenuState createState() => PlayerMenuState();
}

class PlayerMenuState extends State<PlayerMenu> {
  void _plus1() {
    // This is how you close the popup menu and return user selection.
    Navigator.pop<int>(context, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FlatButton(
            onPressed: _plus1,
            child: Center(
                child: Row(
              children: <Widget>[
                Text('Add note'),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                ),
                Icon(Icons.note_add)
              ],
            ))),
        FlatButton(
            onPressed: _plus1,
            child: Center(
                child: Row(
              children: <Widget>[
                Text('Substitution'),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                ),
                Icon(Icons.shuffle)
              ],
            )))
      ],
    );
  }
}
