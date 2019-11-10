import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class InserimentoEvent extends Equatable {
  const InserimentoEvent([List props = const []]) : super(props);
}

class InserimentoStarted extends InserimentoEvent {
  @override
  String toString() => 'InserimentoStarted';
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
