import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import 'FootBallField.dart';
import 'FootballFieldEvent.dart';
import 'FootballFieldProvider.dart';
import 'FootballFieldState.dart';
import 'package:football_system/blocs/model/player_model.dart';

class FootballFieldBloc extends Bloc<FootballFieldEvent, FootballFieldState> {
  final List<int> dimension;

  final FootballFieldProvider footballFieldProvider = FootballFieldProvider();
  List<Player> addedPlayers;
  List<Player> availablePlayers;

  FootballFieldBloc({@required this.dimension, this.availablePlayers})
      : assert(dimension != null) {
    addedPlayers = List<Player>();
    currentInstantanea = FootballField(dimension: this.dimension);
    instantanee = List<FootballField>();
  }

  FootballField currentInstantanea;
  List<FootballField> instantanee;

  FootballFieldState get initialState => FootballFieldCreated();

  @override
  Stream<FootballFieldState> mapEventToState(
    FootballFieldEvent event,
  ) async* {
    if (event is InitFootballField) {
      yield FootballFieldInitiated();
    }
    if (event is CreateFootballField) {
      //mostro il campo di calcio con modulo predefinito o senza
      yield FootballFieldCreated();
    }
    //evento per aggiornare la view con le info del campo
    if (event is RefreshFootballField) {
      yield FootballFieldRefreshed();
    }
    if (event is EditFootballField) {
      yield FootballFieldEdit();
    }
    if (event is AddFootballPlayerToField) {
      //indice della lista che userò per fare il pop del player
      addedPlayers.add(event.player);
      availablePlayers = availablePlayers
          .where((player) => player.id != event.player.id)
          .toList();

      yield FootballFieldRefreshed();
    }
    if (event is EditFootballField) {
      currentInstantanea[event.player.posizione] = event.player;
      yield FootballFieldRefreshed();
    }
    if (event is FinishInstantanea) {
      print(event.toString());
    }
  }
}
