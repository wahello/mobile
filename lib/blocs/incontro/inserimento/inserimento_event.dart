import 'package:equatable/equatable.dart';
import 'package:football_system/blocs/addForm/addFormSingleInstance.dart';
import 'package:meta/meta.dart';

abstract class InserimentoEvent extends Equatable {
  const InserimentoEvent([List props = const []]) : super(props);
}

class InserimentoStarted extends InserimentoEvent {
  @override
  String toString() => 'InserimentoStarted';
}

class SubmitFormEvent extends InserimentoEvent {
  final List dataToSend;
  final TypeAddForm type;
  final String id;

  SubmitFormEvent(this.dataToSend, this.type, this.id);

  @override
  String toString() => 'SubmitFormEvent';
}

class InserimentoLoadingEvent extends InserimentoEvent {
  @override
  String toString() {
    return 'InserimentoLoadingEvent';
  }
}

class InserimentoFinishEvent extends InserimentoEvent {
  @override
  String toString() {
    return 'InserimentoFinishEvent';
  }
}

class GetGendersEvent extends InserimentoEvent {
  @override
  String toString() {
    return 'GetGendersEvent';
  }
}

class GetChampionshipsEvent extends InserimentoEvent {
  @override
  String toString() {
    return 'GetChampionshipsEvent';
  }
}

class GetMatchesEvent extends InserimentoEvent {
  @override
  String toString() => 'GetMatchesEvent';
}

class GetCategoriesEvent extends InserimentoEvent {
  @override
  String toString() => 'GetCategoriesEvent';
}

class GetTeamsEvent extends InserimentoEvent {
  @override
  String toString() => 'GetTeamsEvent';
}

class GetTournamentsEvent extends InserimentoEvent {
  final String inputTextValue;

  GetTournamentsEvent({
    @required this.inputTextValue,
  }) : super([inputTextValue]);

  @override
  String toString() =>
      'GetTournamentsEvent { inputTextValue: $inputTextValue }';
}

class GetPlayersEvent extends InserimentoEvent {
  @override
  String toString() => 'GetPlayersEvent';
}

class GetCoachesEvent extends InserimentoEvent {
  @override
  String toString() => 'GetCoachesEvent';
}

class InserisciIncontroEvent extends InserimentoEvent {
  @override
  String toString() => 'InserisciIncontroEvent';
}

class InserisciModuloEvent extends InserimentoEvent {
  @override
  String toString() => 'InserisciModuloEvent';
}
