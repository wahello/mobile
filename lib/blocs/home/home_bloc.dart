import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:football_system/blocs/home/index.dart';
import 'package:football_system/blocs/stuff/calls_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({@required this.callsRepository}) : assert(callsRepository != null);

  final CallsRepository callsRepository;

  HomeState get initialState => HomeUninitialized();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is HomeStarted) {
      yield HomeUninitialized();
      await Future.delayed(Duration(seconds: 2));
      yield HomeInitialized();
    }
    if (event is InserimentoIncontroEvent) {
      yield InserimentoIncontroState();
    }
  }
}
