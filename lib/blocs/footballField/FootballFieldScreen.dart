import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_system/blocs/footballField/FootballFieldBloc.dart';
import 'package:football_system/blocs/footballField/FootballFieldEvent.dart';
import 'package:football_system/blocs/footballField/FootballFieldState.dart';
import 'package:football_system/blocs/incontro/inserimento/inserimento_bloc.dart';
import 'package:football_system/blocs/model/module_model.dart';
import 'package:football_system/blocs/model/player_model.dart';
import 'package:football_system/blocs/stuff/event.dart';
import 'package:football_system/blocs/stuff/field.dart';
import 'package:football_system/blocs/stuff/index.dart';
import 'package:football_system/custom_icon/soccerplayer_icons.dart';
import 'package:shared/shared.dart';

class FootballFieldScreen extends StatefulWidget {
  final double lato;
  final Field posizioni = Field();
  Module moduloScelto;

  final List playersFromBloc;

  FootballFieldScreen(
      {Key key, @required this.lato, this.playersFromBloc, this.moduloScelto})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return FootballFieldScreenState(playersFromBloc, moduloScelto);
  }
}

class FootballFieldScreenState extends State<FootballFieldScreen> {
  var _tapIndex;
  List<Player> players;
  TextEditingController _noteFieldController;
  List<int> convertedPositions;
  Module moduloScelto;
  final Map<String, Player> playersPlaced = new Map();

  FootballFieldScreenState(this.players, this.moduloScelto) {
    convertedPositions = convertCordinates(moduloScelto);
  }

  List<int> convertCordinates(Module module) {
    List<int> indexesList = List<int>();

    for (int i = 0; i < module.positions.length; i++) {
      List<String> xy = module.positions[i].split(',');
      int x = int.parse(xy[0]);
      int y = int.parse(xy[1]);
      //TODO : rendere dinamico
      indexesList.add(x * 9 + y);
    }

    return indexesList;
  }

  void _plus1() {
    // This is how you close the popup menu and return user selection.
    Navigator.pop<int>(context, 1);
  }

  void saveNote(String note, playerId) {
    //TODO recuperare lista note da incontro
    Note(playerId, note);
    //TODO aggiungere alla lista
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
                          playersPlaced[_tapIndex].id);
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

  @override
  void initState() {
    super.initState();
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
                    addEvent(playersPlaced[index].id, EventType.yellowCard,
                        0); //TODO recuperare istantaneaID
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.sd_card,
                        color: Colors.yellow,
                      ),
                      Text('Cartellino Giallo')
                    ],
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    addEvent(playersPlaced[index].id, EventType.redCard,
                        0); //TODO recuperare istantaneaID
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.sd_card,
                        color: Colors.red,
                      ),
                      Text('Cartellino Rosso')
                    ],
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    addEvent(playersPlaced[index].id, EventType.goal,
                        0); //TODO recuperare istantaneaID
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.radio_button_unchecked),
                      Text('Goal')
                    ],
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    addEvent(playersPlaced[index].id, EventType.substitution,
                        0); //TODO recuperare istantaneaID
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.compare_arrows),
                      Text('Substituion')
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

// Passo come parametro il giocatore selezionato
  void _showCustomMenu(int index) {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return playersPlaced.containsKey(_tapIndex ?? '')
              ? Column(
                  children: <Widget>[
                    FlatButton(
                        onPressed: openAlertBox,
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
                        onPressed: () {
                          _showEventMenu(index);
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
                          BlocProvider.of<FootballFieldBloc>(context).add(
                              RemoveFootballPlayerFromField(
                                  playersPlaced[_tapIndex]));
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
                        itemCount: players.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return ListTile(
                            title: Text(players[index].name),
                            onTap: () => {
                              BlocProvider.of<FootballFieldBloc>(context).add(
                                  AddFootballPlayerToField(
                                      player: players[index], posizione: index))
                            },
                            trailing: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                            ),
                          );
                        })
                  ]));
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FootballFieldBloc, FootballFieldState>(
        bloc: FootballFieldBloc(dimension: [11, 11]), //TODO: rendere dinamico
        builder: (BuildContext context, FootballFieldState state) {
          return Scaffold(
              body: Center(
                  child: false
                      ? LoadingIndicator()
                      : FractionallySizedBox(
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
                                        (index) => (convertedPositions
                                                .contains(index))
                                            ? state is FootballFieldCreated
                                                ? _getPlayerOrPlaceHolder(
                                                    index,
                                                  )
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
                                                                  size: widget
                                                                      .lato,
                                                                ),
                                                                feedback: Icon(
                                                                  Soccerplayer
                                                                      .soccer_player,
                                                                  size: widget
                                                                      .lato,
                                                                ),
                                                                childWhenDragging:
                                                                    Icon(
                                                                  Soccerplayer
                                                                      .soccer_player,
                                                                  size: widget
                                                                      .lato,
                                                                ),
                                                              )
                                                            : Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                color: Colors
                                                                    .transparent,
                                                                shape: BoxShape
                                                                    .rectangle,
                                                              ));
                                                      })
                                                    : Container(
                                                        decoration:
                                                            BoxDecoration(
                                                        color:
                                                            Colors.transparent,
                                                        shape:
                                                            BoxShape.rectangle,
                                                      ))
                                            : Container(
                                                decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                shape: BoxShape.rectangle,
                                              )))))
                          ]))),
              floatingActionButton: Stack(
                children: <Widget>[
                  FloatingActionButton.extended(
                    tooltip: 'crea instantanea',
                    onPressed: () {
                      BlocProvider.of<FootballFieldBloc>(context)
                          .add(FinishInstantanea());
                    },
                    label: false
                        ? Text('creazione incontro in corso ...')
                        : Text('crea instantanea'),
                    icon: Icon(false ? Icons.save : Icons.thumb_up),
                    backgroundColor:
                        false ? MainColors.DISABLED : MainColors.PRIMARY,
                  ),
                ],
              ));
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
