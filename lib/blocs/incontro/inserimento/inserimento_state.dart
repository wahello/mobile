import 'package:equatable/equatable.dart';
import 'package:football_system/blocs/model/incontro_model.dart';
import 'package:meta/meta.dart';

abstract class InserimentoState extends Equatable {
  const InserimentoState([List props = const []]) : super(props);
}

class InitialInserimentoState extends InserimentoState {
  @override
  List<Object> get props => [];
}

class InserimentoInitialized extends InserimentoState {
  @override
  String toString() => 'InserimentoInitialized';
}

class InserimentoUninitialized extends InserimentoState {
  @override
  String toString() => 'InserimentoUninitialized';
}

class InserimentoFailure extends InserimentoState {
  final String error;

  InserimentoFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'InserimentoFailure { error: $error }';
}

class InserimentoLoadingState extends InserimentoState {
  @override
  String toString() => 'InserimentoLoadingState';
}

class InserimentoFinishState extends InserimentoState {
  @override
  String toString() => 'InserimentoFinishState';
}

class GetGendersState extends InserimentoState {
  @override
  String toString() => 'GetGendersState';
}

class GetChampionshipsState extends InserimentoState {
  @override
  String toString() => 'GetChampionshipsState';
}

class GetTeamsState extends InserimentoState {
  @override
  String toString() => 'GetTeamsState';
}

class GetMatchesState extends InserimentoState {
  final String selectedChampionships;

  GetMatchesState({@required this.selectedChampionships})
      : super([selectedChampionships]);

  @override
  String toString() =>
      'GetMatchesState { selectedChampionships: $selectedChampionships }';
}

class GetCategoriesState extends InserimentoState {
  final String selectedGender;
  final String selectedChampionships;
  final String selectedMatches;

  GetCategoriesState(
      {@required this.selectedGender,
      @required this.selectedChampionships,
      @required this.selectedMatches})
      : super([selectedGender, selectedChampionships, selectedMatches]);

  @override
  String toString() =>
      'GetCategoriesState { selectedGender: $selectedGender, selectedChampionships: $selectedChampionships, selectedMatches: $selectedMatches }';
}

class GetTournamentsState extends InserimentoState {
  @override
  String toString() => 'GetTournamentsState';
}

class GetPlayersState extends InserimentoState {
  @override
  String toString() => 'GetPlayersState';
}

class GetCoachesState extends InserimentoState {
  @override
  String toString() => 'GetCoachesState';
}

class InserisciIncontroState extends InserimentoState {
  final Incontro incontro;

  InserisciIncontroState({
    @required this.incontro,
  }) : super([incontro]);

  @override
  String toString() => 'InserisciIncontroState { incontro: $incontro }';
}
