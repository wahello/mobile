import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {}

class HomeInitialized extends HomeState {
  @override
  String toString() => 'HomeInitialized';
}

class HomeUninitialized extends HomeState {
  @override
  String toString() => 'HomeUninitialized';
}

class InserimentoIncontroState extends HomeState {
  @override
  String toString() => 'InserimentoIncontroState';
}
