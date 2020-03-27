import 'package:football_system/blocs/model/coach_model.dart';
import 'package:football_system/blocs/model/player_model.dart';
import 'package:football_system/blocs/model/team_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'addFormModel.g.dart';

@JsonSerializable()
class AddFormModel {
  final String name;
  final String number;
  final String year;

  AddFormModel({this.name, this.number, this.year});

  Player getPlayerFromModel() {
    return new Player(name: this.name, number: this.number);
  }

  Team getTeamFromModel() {
    return new Team(0, this.name);
  }

  Coach getCoachFromModel() {
    return new Coach(0, this.name);
  }

  @override
  String toString() {
    return '$name' +
        (number != '' ? ' $number' : '') +
        (year != '' ? ' $year' : '');
  }

  factory AddFormModel.fromJson(Map<String, dynamic> json) =>
      _$AddFormModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddFormModelToJson(this);
}
