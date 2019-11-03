import 'package:equatable/equatable.dart';
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
