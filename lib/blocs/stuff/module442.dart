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
  final Map<int, Player> playersPlaced = new Map();
  final List<Player> players = new List(11);

  Module442({Key key, @required this.lato}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return Module442State();
  }
}

class Module442State extends State<Module442> {
  var _tapPosition;
  var _tapIndex;

// Passo come parametro il giocatore selezionato
  void _showCustomMenu() {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();

    showMenu(
            context: context,
            items: <PopupMenuEntry<int>>[
              PlayerMenu(
                  widget.playersPlaced, widget.players, _tapIndex)
            ],
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

  void _setIndex(int currentIndex) {
    _tapIndex = currentIndex;
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
                          ? state is FootballFieldCreated
                              ? _getPlayerOrPlaceHolder(index)
                              : state is FootballFieldEdit
                                  ? DragTarget(builder: (BuildContext context,
                                      List candidateData, List rejectedData) {
                                      return (index == 11 ||
                                              index == 15 ||
                                              index == 57 ||
                                              index == 59 ||
                                              index == 37 ||
                                              index == 43 ||
                                              index == 95 ||
                                              index == 93 || //=> posizioni[]
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

// Controllo se nella mappa dei giocatori già inseriti è presente qualcuno per questo indice
// se si lo ritorno altrimenti restituisco un placeholder
  Widget _getPlayerOrPlaceHolder(int index) {
    Map<int, Player> players = widget.playersPlaced;
    if (players.containsKey(index)) {
      // Ritorno i dati del giocatore
      return GestureDetector(
          // This does not give the tap position ...
          onLongPress: _showCustomMenu,
          onTapDown: _storePosition,
          onTap: () => {_tapIndex = index},
          child: Container(
            child: Column(
              children: <Widget>[
                Icon(
                  Soccerplayer.soccer_player,
                  size: widget.lato,
                ),
                Row(
                  children: <Widget>[
                    Text(players[index].numero),
                    Text(players[index].name)
                  ],
                )
              ],
            ),
          ));
    } else {
      // Ritorno un placeholder
      return GestureDetector(
          onLongPress: _showCustomMenu,
          onTapDown: _storePosition,
          child: Container(
            child: Icon(
              Soccerplayer.soccer_player,
              size: widget.lato,
            ),
          ));
    }
  }
}

class PlayerMenu extends PopupMenuEntry<int> {
  @override
  double height = 100;
  // height doesn't matter, as long as we are not giving
  // initialValue to showMenu().

//Questo valore mi dice se ho fatto longPress su una cella con un giocatore
// o con un placeholder
  final Map<int, Player> _playerPlaced;
  final List<Player> players;
  final int _tapIndex;

  PlayerMenu(this._playerPlaced, this.players, this._tapIndex);


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
    return widget._playerPlaced.containsKey(widget._tapIndex)
        ? Column(
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
                  ))),
              FlatButton(
                  onPressed: _plus1,
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
          )
        : ListView.builder(
            itemCount: widget.players.length,
            itemBuilder: (context, index) {
              return FlatButton(
                  onPressed: _plus1,
                  child: Center(
                      child: Row(
                    children: <Widget>[
                      Text(widget.players[index].name),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      ),
                      Text(widget.players[index].numero),
                    ],
                  )));
            });
  }
}
