import 'package:equatable/equatable.dart';

abstract class InserimentoEvent extends Equatable {
  const InserimentoEvent();
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
