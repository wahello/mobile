import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:football_system/blocs/stuff/calls_repository.dart';

import './index.dart';

class InserimentoBloc extends Bloc<InserimentoEvent, InserimentoState> {
  final CallsRepository callsRepository = new CallsRepository();

  @override
  InserimentoState get initialState => InitialInserimentoState();

  @override
  Stream<InserimentoState> mapEventToState(
    InserimentoEvent event,
  ) async* {
    if (event is InserimentoStarted) {
      yield InserimentoLoadingState();
      yield InserimentoUninitialized();
      yield InserimentoInitialized();
    }
    if (event is InserimentoLoadingEvent) {
      yield InserimentoLoadingState();
    }
    if (event is InserimentoFinishEvent) {
      yield InserimentoFinishState();
    }
  }
}
