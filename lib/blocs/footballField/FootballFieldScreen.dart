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
  // Giocatori inseriti sul campo
  final Map<String, Player> playersPlaced = new Map();
  // Giocatori da inserire (ricevuti da API)
  List<Player> players = new List(11);

  final List playersFromBloc;

  FootballFieldScreen({Key key, @required this.lato, this.playersFromBloc})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return FootballFieldScreenState();
  }
}

class FootballFieldScreenState extends State<FootballFieldScreen> {
  var _tapPosition;
  var _tapIndex;
  List<Player> players = new List(11);

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.playersFromBloc.length; i++) {
      players[i] = new Player(name: widget.playersFromBloc[i]);
    }
  }

// Passo come parametro il giocatore selezionato
  void _showCustomMenu() {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();

    showMenu(
            context: context,
            items: <PopupMenuEntry<int>>[
              PlayerMenu(
                playerPlaced: widget.playersPlaced,
                players: players,
                tapIndex: _tapIndex,
              )
            ],
            position: RelativeRect.fromRect(
                _tapPosition & Size(40, 40), // smaller rect, the touch area
                Offset.zero & overlay.size // Bigger rect, the entire screen
                ))
        // This is how you handle user selection
        .then<void>((int delta) {});
  }

// Coordinate nello schermo
  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
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
    Map<String, Player> players = widget.playersPlaced;
    if (players.containsKey(index)) {
      // Ritorno i dati del giocatore
      return GestureDetector(
          // This does not give the tap position ...
          onLongPress: _showCustomMenu,
          onTapDown: _storePosition,
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
          onTap: _showCustomMenu,
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
  final Map<String, Player> playerPlaced;
  final List<Player> players;
  final int tapIndex;
  FootballFieldBloc bloc = new FootballFieldBloc(category: 11);

  PlayerMenu(
      {@required this.playerPlaced,
      @required this.players,
      @required this.tapIndex});

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
    return widget.playerPlaced.containsKey(widget.tapIndex ?? '')
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
                        widget.bloc.add(RemoveFootballPlayerFromField(
                            widget.playerPlaced[widget.tapIndex]))
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
            width: 200,
            child: Column(children: <Widget>[
              Text(
                'Players available',
                style: TextStyle(fontSize: 16),
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 20)),
              ListView.builder(
                  shrinkWrap: true,
                  addRepaintBoundaries: true,
                  itemCount: widget.players.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return GestureDetector(
                        onTap: () => {
                              widget.bloc.add(AddFootballPlayerToField(
                                  widget.players[index]))
                            },
                        child: Center(
                            child: Row(
                          children: <Widget>[
                            Text(widget.players[index].name ?? 'Test'),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                            ),
                            Text(widget.players[index].numero ?? '15'),
                          ],
                        )));
                  })
            ]));
  }
}
