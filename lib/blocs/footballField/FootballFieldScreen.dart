import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_system/blocs/footballField/FootballFieldBloc.dart';
import 'package:football_system/blocs/footballField/FootballFieldEvent.dart';
import 'package:football_system/blocs/footballField/FootballFieldState.dart';
import 'package:football_system/blocs/incontro/inserimento/inserimento_bloc.dart';
import 'package:football_system/blocs/model/module_model.dart';
import 'package:football_system/blocs/model/player_model.dart';
import 'package:football_system/blocs/stuff/index.dart';
import 'options_screen.dart';
import 'package:shared/shared.dart';

class FootballFieldScreen extends StatefulWidget {
  InserimentoBloc inserimentoIncontroBloc;
  FootballFieldBloc footballFieldBloc;
  final Function(Widget) notifyParent;
  final Function(Widget) notifyAction;
  final bool isHome;
  final double lato;

  FootballFieldScreen(
      {Key key,
      this.isHome,
      this.notifyAction,
      this.notifyParent,
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
      {this.inserimentoIncontroBloc, this.footballFieldBloc});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.notifyParent(widget.isHome
        ? Text(inserimentoIncontroBloc
            .getTeamNameById(inserimentoIncontroBloc.selectedTeamHome))
        : Text(inserimentoIncontroBloc
            .getTeamNameById(inserimentoIncontroBloc.selectedTeamAway)));
    return BlocBuilder<FootballFieldBloc, FootballFieldState>(
        bloc: footballFieldBloc,
        builder: (BuildContext context, FootballFieldState state) {
          return Scaffold(
              body: Center(
                  child: FractionallySizedBox(
                      heightFactor: 1,
                      widthFactor: 1,
                      child: Stack(alignment: Alignment.center, children: [
                        Image.asset('assets/images/football_field.jpg'),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                              9,
                              (i) => SingleChildScrollView(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: List.generate(
                                          11,
                                          (j) => _getPlayerOrPlaceHolder(
                                              i, j, state)),
                                    ),
                                  )),
                        )
                      ]))));
        });
  }

// Controllo se nella mappa dei giocatori già inseriti è presente qualcuno per questo indice
// se si lo ritorno altrimenti restituisco un placeholder
  Widget _getPlayerOrPlaceHolder(int x, int y, FootballFieldState state) {
    if (footballFieldBloc.footballField.players[x][y] != null) {
      // Ritorno i dati del giocatore
      return GestureDetector(
        // This does not give the tap position ...
        onTap: () => {
          if (footballFieldBloc.footballField.players[x][y].id.toString() ==
              "0")
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListPlayerScreen(
                            x: x,
                            y: y,
                            footballFieldBloc: footballFieldBloc,
                            inserimentoBloc: inserimentoIncontroBloc,
                          )))
            }
          else
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OptionsScreen(
                          x: x, y: y, footballFieldBloc: footballFieldBloc)))
            }
        },
        onDoubleTap: () => {
          footballFieldBloc.footballField.players[x][y].notes = [""],
          footballFieldBloc.availablePlayers
              .add(footballFieldBloc.footballField.players[x][y]),
          footballFieldBloc.footballField.players[x][y] = Player(
              id: 0,
              name: "aggiungi",
              number: "",
              posizione: "$x,$y",
              ruolo: "")
        }, //Salvo la cella che ho toccato
        child: Column(
          children: <Widget>[
            Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/maglia.png")))),
            Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  border: Border.all(width: 2), color: Colors.white),
              child: Row(
                children: <Widget>[
                  Text(
                    footballFieldBloc.footballField.players[x][y].name,
                    style: TextStyle(
                        color: MainColors.PRIMARY,
                        fontWeight: FontWeight.bold,
                        fontSize: 10),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        border: footballFieldBloc.footballField.players[x][y].id
                                    .toString() ==
                                "0"
                            ? null
                            : Border.all(width: 1)),
                    child: Text(
                      footballFieldBloc.footballField.players[x][y].id
                                  .toString() ==
                              "0"
                          ? ""
                          : footballFieldBloc.footballField.players[x][y].number
                              .toString(),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    } else {
      // Ritorno un placeholder
      return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ListPlayerScreen(
                          x: x,
                          y: y,
                          footballFieldBloc: footballFieldBloc,
                          inserimentoBloc: inserimentoIncontroBloc,
                        )));
          },
          child: Container());
    }
  }
}

class ListPlayerScreen extends StatefulWidget {
  InserimentoBloc inserimentoBloc;
  FootballFieldBloc footballFieldBloc;
  int x;
  int y;

  ListPlayerScreen(
      {this.x, this.y, this.inserimentoBloc, this.footballFieldBloc});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ListPlayerScreenState(
        inserimentoBloc: inserimentoBloc, footballFieldBloc: footballFieldBloc);
  }
}

class ListPlayerScreenState extends State<ListPlayerScreen> {
  InserimentoBloc inserimentoBloc;
  FootballFieldBloc footballFieldBloc;

  ListPlayerScreenState({this.inserimentoBloc, this.footballFieldBloc});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (footballFieldBloc.availablePlayers.length > 0) {
      return Center(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: MainColors.PRIMARY,
            ),
            body: Center(
                child: GridView.count(
              crossAxisCount: 2,
              children: footballFieldBloc.availablePlayers
                  .map((player) => ListTile(
                        onTap: () => {
                          footballFieldBloc.add(AddFootballPlayerToField(
                              player: player, x: widget.x, y: widget.y)),
                          Navigator.pop(context)
                        },
                        title: Container(
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                    color: MainColors.PRIMARY,
                                    border: Border.all(width: 2),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/maglia.png"))),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height /
                                        10),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      player.number,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      player.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ))),
      );
    } else {
      Navigator.pop(context);
      return Center(
          child: Scaffold(
        body: LoadingIndicator(),
      ));
    }
  }
}
