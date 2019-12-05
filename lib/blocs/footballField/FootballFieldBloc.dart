import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import 'FootBallField.dart';
import 'FootballFieldEvent.dart';
import 'FootballFieldProvider.dart';
import 'FootballFieldRepository.dart';
import 'FootballFieldState.dart';

class FootballFieldBloc extends Bloc<FootballFieldEvent, FootballFieldState> {
  final int category;
  int _indexInstantanea = -1;
  var instantanee = List<FootballField>();

  final FootballFieldProvider footballFieldProvider = FootballFieldProvider();
  // final FootballFieldRepository footballFieldRepository =
  //     FootballFieldRepository();

  FootballFieldBloc({@required this.category}) : assert(category != null) {
    addInstantanea();
  }

  void _assignPlayerToInstantanea(List players) {
    _getCurrentInstantanea().players = players;
  }

  void addInstantanea() {
    _indexInstantanea++;
    instantanee[_indexInstantanea] = new FootballField(category: this.category);
  }

  FootballField _getCurrentInstantanea() {
    return instantanee[_indexInstantanea];
  }

  FootballField currentInstantanea;

  FootballFieldState get initialState => FootballFieldCreated();

  @override
  Stream<FootballFieldState> mapEventToState(
    FootballFieldEvent event,
  ) async* {
    if (event is InitFootballField) {
      _assignPlayerToInstantanea(event.players);
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
      var index = _getCurrentInstantanea()
          .players
          .indexWhere((player) => player.id == event.player.id);
      //posiziono il player nella sua posizione
      _getCurrentInstantanea()[event.player.posizione] = event.player;
      _getCurrentInstantanea().players.removeAt(index);

      yield FootballFieldRefreshed();
    }
    if (event is EditFootballField) {
      _getCurrentInstantanea()[event.player.posizione] = event.player;
      yield FootballFieldRefreshed();
    }
  }
}
