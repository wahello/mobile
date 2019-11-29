import 'package:equatable/equatable.dart';
import 'package:football_system/blocs/model/player_model.dart';

abstract class FootballFieldEvent extends Equatable {
  FootballFieldEvent([List props = const []]) : super(props);
}

class InitFootballField extends FootballFieldEvent {
  @override
  String toString() => 'InitFootballField';
}

class CreateFootballField extends FootballFieldEvent {
  @override
  String toString() => 'CreateFootballField';
}

class AddFootballPlayerToField extends FootballFieldEvent {
  final Player player;

  AddFootballPlayerToField(this.player);

  @override
  String toString() => 'AddFootballPlayerToField';
}

class RemoveFootballPlayerFromField extends FootballFieldEvent {
  final Player player;

  RemoveFootballPlayerFromField(this.player);

  @override
  String toString() => 'RemoveFootballPlayerFromField';
}

class RefreshFootballField extends FootballFieldEvent {
  String oldPosition;
  String newPosition;

  RefreshFootballField({this.oldPosition, this.newPosition});

  @override
  String toString() => 'RefreshFootballField';
}

class EditFootballField extends FootballFieldEvent {
  Player player;
  String dataType;
  String dataValue;

  EditFootballField({this.player, this.dataType, this.dataValue}) {
    switch (dataType) {
      case 'note':
        {
          player.note = dataValue;
          break;
        }
      default:
        break;
    }
  }
  @override
  String toString() => 'EditFootballField';
}
