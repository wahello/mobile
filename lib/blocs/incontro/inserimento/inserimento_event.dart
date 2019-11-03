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
