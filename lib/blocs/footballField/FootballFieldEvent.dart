import 'package:equatable/equatable.dart';

abstract class FootballFieldEvent extends Equatable {
  FootballFieldEvent([List props = const []]) : super(props);
}

class InitFootballField extends FootballFieldEvent{
  @override
  String toString() => 'InitFootballField';
}

class CreateFootballField extends FootballFieldEvent {
  @override
  String toString() => 'CreateFootballField';
}

class RefreshFootballField extends FootballFieldEvent {

  String oldPosition;
  String newPosition;

  RefreshFootballField({this.oldPosition,this.newPosition});
  
  @override 
  String toString() => 'RefreshFootballField';
}


class EditFootballField extends FootballFieldEvent {
  @override
  String toString() => 'EditFootballField';
}
