import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_system/blocs/footballField/FootballFieldBloc.dart';
import 'package:football_system/blocs/footballField/FootballFieldEvent.dart';
import 'package:football_system/blocs/footballField/FootballFieldState.dart';
import 'package:football_system/blocs/footballField/players_screen.dart';
import 'package:football_system/blocs/incontro/inserimento/inserimento_bloc.dart';
import 'package:football_system/blocs/model/module_model.dart';
import 'package:football_system/blocs/model/player_model.dart';
import 'package:football_system/blocs/stuff/event.dart';
import 'package:football_system/blocs/stuff/field.dart';
import 'package:football_system/blocs/stuff/index.dart';
import 'package:football_system/custom_icon/soccer_icons_icons.dart';
import 'package:football_system/custom_icon/soccerplayer_icons.dart';
import 'options_screen.dart';
import 'package:shared/shared.dart';

class FootballFieldScreen extends StatefulWidget {
  InserimentoBloc inserimentoIncontroBloc;
  FootballFieldBloc footballFieldBloc;
  final double lato;
  final Field posizioni = Field();

  FootballFieldScreen(
      {Key key,
      @required this.lato,
      this.inserimentoIncontroBloc,
      this.footballFieldBloc})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return FootballFieldScreenState(
        inserimentoIncontroBloc: inserimentoIncontroBloc,
        footballFieldBloc: footballFieldBloc);
  }
}

class FootballFieldScreenState extends State<FootballFieldScreen> {
  InserimentoBloc inserimentoIncontroBloc;
  FootballFieldBloc footballFieldBloc;

  List<Player> players;

  List<int> convertedPositions;
  final Map<String, Player> playersPlaced = new Map();

  FootballFieldScreenState(
      {this.inserimentoIncontroBloc, this.footballFieldBloc}) {
    convertedPositions =
        convertCordinates(inserimentoIncontroBloc.incontro.module);
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FootballFieldBloc, FootballFieldState>(
        bloc: footballFieldBloc, //TODO: rendere dinamico
        builder: (BuildContext context, FootballFieldState state) {
          return Scaffold(
              body: Center(
                  child: FractionallySizedBox(
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
                                        ? (state is FootballFieldCreated ||
                                                state is FootballFieldRefreshed)
                                            ? _getPlayerOrPlaceHolder(
                                                index, state)
                                            : state is FootballFieldEdit
                                                ? DragTarget(builder:
                                                    (BuildContext context,
                                                        List candidateData,
                                                        List rejectedData) {
                                                    return (convertedPositions
                                                            .contains(
                                                                index)) //=> posizioni[12][4]
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
                                                            childWhenDragging:
                                                                Icon(
                                                              Soccerplayer
                                                                  .soccer_player,
                                                              size: widget.lato,
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
                                                    decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    shape: BoxShape.rectangle,
                                                  ))
                                        : Container(
                                            //todo: cambiare
                                            margin: EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                                border: Border.all(width: 1)),
                                          ))))
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
  Widget _getPlayerOrPlaceHolder(int index, FootballFieldState state) {
    if (footballFieldBloc.footballField.players[index] != null) {
      // Ritorno i dati del giocatore
      Widget _child = (state is FootballFieldRefreshed &&
              footballFieldBloc.currentPlayer == index)
          ? GestureDetector(
              // This does not give the tap position ...
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            OptionsScreen(footbalFieldBloc: footballFieldBloc)))
              }, //Salvo la cella che ho toccato
              child: Container(
                child: Column(children: <Widget>[
                  Icon(
                    Soccerplayer.soccer_player,
                    color:
                        footballFieldBloc.footballField.players[index] != null
                            ? Colors.red
                            : Colors.black,
                    size: widget.lato,
                  ),
                ]),
              ),
            )
          : GestureDetector(
              // This does not give the tap position ...
              onTap: () => {
                footballFieldBloc
                    .add(ShowPlayerOptionsEvent(currentPlayer: index))
              }, //Salvo la cella che ho toccato
              child: Container(
                child: Column(children: <Widget>[
                  Icon(
                    Soccerplayer.soccer_player,
                    color:
                        footballFieldBloc.footballField.players[index] != null
                            ? Colors.red
                            : Colors.black,
                    size: widget.lato,
                  ),
                ]),
              ),
            );

      return _child;
    } else {
      // Ritorno un placeholder
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PlayerPage()));
        },
        child: Container(
          child: Icon(
            Soccerplayer.soccer_player,
            size: widget.lato,
          ),
        ),
      );
    }
  }
}
