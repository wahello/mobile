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

  Widget player_image = Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage("assets/images/maglia.png"))));

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
      List<String> xy = module.positions[i][0].split(',');
      int x = int.parse(xy[0]);
      int y = int.parse(xy[1]);
      //TODO : rendere dinamico
      indexesList.add(x * 5 + y);
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
                              (i) => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: List.generate(
                                        11,
                                        (j) => _getPlayerOrPlaceHolder(
                                            i, j, state)),
                                  )),
                        )
                        // Container(
                        //     // margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        //     child: GridView.count(
                        //         crossAxisSpacing: 10,
                        //         crossAxisCount: 5,
                        //         children: List.generate(
                        //             9 * 5,
                        //             (index) => (convertedPositions
                        //                     .contains(index))
                        //                 ? (state is FootballFieldCreated ||
                        //                         state is FootballFieldRefreshed)
                        //                     ? _getPlayerOrPlaceHolder(
                        //                         index, state)
                        //                     : state is FootballFieldEdit
                        //                         ? player_image
                        //                         : Container(
                        //                             decoration: BoxDecoration(
                        //                             color: Colors.black,
                        //                             shape: BoxShape.rectangle,
                        //                           ))
                        //                 : Container(
                        //                     width: 1,
                        //                     height: 1,
                        //                     decoration: BoxDecoration(
                        //                         border: Border.all(width: 1)),
                        //                   ))))
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
          footballFieldBloc.availablePlayers
              .add(footballFieldBloc.footballField.players[x][y]),
          footballFieldBloc.footballField.players[x][y] = Player(
              id: 0,
              name: "aggiungi",
              numero: "",
              posizione: "$x,$y",
              ruolo: "")
        }, //Salvo la cella che ho toccato
        child: Column(
          children: <Widget>[
            Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/maglia.png")))),
            Text(footballFieldBloc.footballField.players[x][y].name),
            Text(footballFieldBloc.footballField.players[x][y].id.toString() ==
                    "0"
                ? ""
                : footballFieldBloc.footballField.players[x][y].id.toString())
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
                                      player.id.toString(),
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
