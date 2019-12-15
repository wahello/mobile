import 'package:flutter/material.dart';
import 'package:football_system/blocs/footballField/FootBallField.dart';
import 'package:football_system/blocs/footballField/FootballFieldBloc.dart';
import 'package:football_system/blocs/footballField/FootballFieldEvent.dart';
import 'package:football_system/blocs/incontro/inserimento/index.dart';
import 'package:football_system/custom_icon/soccerplayer_icons.dart';

class PlayersScreen extends StatefulWidget {
  InserimentoBloc inserimentoIncontroBloc;
  FootballFieldBloc footballFieldBloc;
  int posizione;

  PlayersScreen(
      {this.inserimentoIncontroBloc, this.footballFieldBloc, this.posizione});

  @override
  _PlayersScreenState createState() => _PlayersScreenState(
      inserimentoIncontroBloc: inserimentoIncontroBloc,
      footballFieldBloc: footballFieldBloc);
}

class _PlayersScreenState extends State<PlayersScreen> {
  InserimentoBloc inserimentoIncontroBloc;
  FootballFieldBloc footballFieldBloc;

  _PlayersScreenState({this.footballFieldBloc, this.inserimentoIncontroBloc});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
          alignment: Alignment.center,
          child: ListView(
              children: footballFieldBloc.availablePlayers
                  .map((player) => Column(
                        children: <Widget>[
                          ListTile(
                              onTap: () => {
                                    Navigator.pop(context),
                                    footballFieldBloc.add(
                                        AddFootballPlayerToField(
                                            player: player,
                                            posizione: widget.posizione))
                                  },
                              title: Center(
                                  child: Container(
                                      width: 150,
                                      height: 120,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color: Colors.redAccent),
                                      child: Container(
                                        padding: EdgeInsets.all(25),
                                        child: Center(
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                player.name,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                player.id.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )))),
                          Divider(color: Colors.redAccent)
                        ],
                      ))
                  .toList())),
    ));
  }
}
