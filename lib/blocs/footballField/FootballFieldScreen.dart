import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_system/blocs/footballField/FootballFieldBloc.dart';
import 'package:football_system/blocs/footballField/FootballFieldEvent.dart';
import 'package:football_system/blocs/footballField/FootballFieldState.dart';
import 'package:football_system/blocs/model/player_model.dart';
import 'package:football_system/blocs/stuff/field.dart';
import 'package:football_system/custom_icon/soccerplayer_icons.dart';

class FootballFieldScreen extends StatefulWidget {
  final double lato;
  final Field posizioni = Field();

  final List playersFromBloc;

  FootballFieldScreen({Key key, @required this.lato, this.playersFromBloc})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return FootballFieldScreenState(playersFromBloc);
  }
}

class FootballFieldScreenState extends State<FootballFieldScreen> {
  var _tapIndex;
  List<Player> players;
  final Map<String, Player> playersPlaced = new Map();

  FootballFieldBloc bloc = new FootballFieldBloc(category: 11);

  FootballFieldScreenState(this.players);
  void _plus1() {
    // This is how you close the popup menu and return user selection.
    Navigator.pop<int>(context, 1);
  }

  @override
  void initState() {
    super.initState();
  }

// Passo come parametro il giocatore selezionato
  void _showCustomMenu(int index) {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          int playerCount = 0;
          for (int i = 0; i < players.length; i++) {
            if (players[i] != null) {
              playerCount++;
            }
          }
          return playersPlaced.containsKey(_tapIndex ?? '')
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
                        onPressed: () => {
                              bloc.add(RemoveFootballPlayerFromField(
                                  playersPlaced[_tapIndex]))
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
                )
              : Container(
                  height: 300,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(10),
                          topRight: const Radius.circular(10))),
                  child: Column(children: <Widget>[
                    Text(
                      'Players available',
                      style: TextStyle(fontSize: 16),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 20)),
                    ListView.builder(
                        shrinkWrap: true,
                        addRepaintBoundaries: true,
                        itemCount: playerCount,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: GestureDetector(
                                  onTap: () => {
                                        bloc.add(AddFootballPlayerToField(
                                            players[index]))
                                      },
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Soccerplayer.soccer_player,
                                        size: 25,
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(50, 0, 0, 0),
                                      ),
                                      Text(players[index].name ?? 'Test'),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(50, 0, 0, 0),
                                      ),
                                      Text(players[index].numero ?? '15'),
                                    ],
                                  ))));
                        })
                  ]));
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FootballFieldBloc, FootballFieldState>(
        bloc: FootballFieldBloc(category: 13), //TODO: rendere dinamico
        builder: (BuildContext context, FootballFieldState state) {
          return FractionallySizedBox(
              heightFactor: 0.85,
              widthFactor: 0.85,
              child: Stack(alignment: Alignment.center, children: [
                Image.asset('assets/A1QA94rgGUL._AC_SY879_.jpg'),
                Container(
                    margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: GridView.count(
                        padding: EdgeInsets.all(0),
                        crossAxisSpacing: 4,
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
                                                      Soccerplayer
                                                          .soccer_player,
                                                      size: widget.lato,
                                                    ),
                                                    feedback: Icon(
                                                      Soccerplayer
                                                          .soccer_player,
                                                      size: widget.lato,
                                                    ),
                                                    childWhenDragging: Icon(
                                                      Soccerplayer
                                                          .soccer_player,
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
                                  )))))
              ]));
        });
  }

// Controllo se nella mappa dei giocatori già inseriti è presente qualcuno per questo indice
// se si lo ritorno altrimenti restituisco un placeholder
  Widget _getPlayerOrPlaceHolder(int index) {
    Map<String, Player> players = playersPlaced;
    if (players.containsKey(index)) {
      // Ritorno i dati del giocatore
      return GestureDetector(
          // This does not give the tap position ...
          onLongPress: () {
            _showCustomMenu(index);
          },
          onTap: () => {_tapIndex = index}, //Salvo la cella che ho toccato
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
          onTap: () {
            _showCustomMenu(index);
          },
          child: Container(
            child: Icon(
              Soccerplayer.soccer_player,
              size: widget.lato,
            ),
          ));
    }
  }
}
