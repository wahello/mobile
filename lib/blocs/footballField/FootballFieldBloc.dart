import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import 'FootballFieldEvent.dart';
import 'FootballFieldProvider.dart';
import 'FootballFieldRepository.dart';
import 'FootballFieldState.dart';

class FootballFieldBloc extends Bloc<FootballFieldEvent, FootballFieldState> {
  FootballFieldBloc(
      {@required this.footballFieldProvider,
      @required this.footballFieldRepository})
      : assert(footballFieldProvider != null);

  final FootballFieldProvider footballFieldProvider;
  final FootballFieldRepository footballFieldRepository;

  FootballFieldState get initialState => FootballFieldCreated();

  @override
  Stream<FootballFieldState> mapEventToState(
    FootballFieldEvent event,
  ) async* {
    if (event is CreateFootballField) {
      yield FootballFieldCreated();
    }
    if (event is RefreshFootballField) {
      yield FootballFieldRefreshed();
    }
  }
}
