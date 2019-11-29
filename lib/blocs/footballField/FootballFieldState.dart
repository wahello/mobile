import 'package:equatable/equatable.dart';

abstract class FootballFieldState extends Equatable {}

class FootballFieldCreated extends FootballFieldState {
  @override
  String toString() {
    return 'FootballFieldCreated';
  }
}

class FootballFieldInitiated extends FootballFieldState {
  @override
  String toString() {
    return 'FootballFieldInitiated';
  }
}

class FootballFieldRefreshed extends FootballFieldState {
  @override
  String toString() {
    return 'FootballFieldRefreshed';
  }
}

class FootballFieldEdit extends FootballFieldState {
  @override
  String toString() {
    return 'FootballFieldEdit';
  }
}
