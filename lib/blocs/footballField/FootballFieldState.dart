import 'package:equatable/equatable.dart';

abstract class FootballFieldState extends Equatable {}

class FootballFieldCreated extends FootballFieldState {
  @override
  String toString() {
    return 'FootballFieldCreated';
  }
}

class FootballFieldRefreshed extends FootballFieldState {
  @override
  String toString() {
    return 'FootballFieldRefreshed';
  }
}
