import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import 'FootBallField.dart';
import 'FootballFieldEvent.dart';
import 'FootballFieldProvider.dart';
import 'FootballFieldRepository.dart';
import 'FootballFieldState.dart';

class FootballFieldBloc extends Bloc<FootballFieldEvent, FootballFieldState> {

  final int rows;
  final int columns;
  
  final FootballFieldProvider footballFieldProvider;
  final FootballFieldRepository footballFieldRepository;


  FootballFieldBloc(
      {@required this.footballFieldProvider,
      @required this.footballFieldRepository,
      @required this.rows,
      @required this.columns})
      : assert(footballFieldProvider != null &&
      footballFieldRepository!=null &&
      rows != null &&
      columns != null){
        currentInstantanea = FootballField(rows: this.rows,columns: this.columns);
        instantanee = List<FootballField>();
        instantanee.add(currentInstantanea);
      }


  FootballField currentInstantanea;
  List<FootballField> instantanee;

  FootballFieldState get initialState => FootballFieldCreated();

  @override
  Stream<FootballFieldState> mapEventToState(
    FootballFieldEvent event,
  ) async* {
    if (event is CreateFootballField) {
      //mostro il campo di calcio con modulo predefinito o senza
      yield FootballFieldCreated();
    }
    if (event is RefreshFootballField) {

      String oldPosition =  event.oldPosition;
      String newPosition =  event.newPosition;
      
      currentInstantanea[newPosition] = currentInstantanea[oldPosition] ;
      currentInstantanea[oldPosition]  = 0;

      yield FootballFieldRefreshed();
    }
  }
}
