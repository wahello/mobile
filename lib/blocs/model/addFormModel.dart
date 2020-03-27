import 'package:football_system/blocs/model/coach_model.dart';
import 'package:football_system/blocs/model/player_model.dart';
import 'package:football_system/blocs/model/team_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'addFormModel.g.dart';

@JsonSerializable()
class AddFormModel {
  final String nome;
  final String number;
  final String anno;

  AddFormModel({this.nome, this.number, this.anno});

  Player getPlayerFromModel() {
    return new Player(name: this.nome, number: this.number);
  }

  Team getTeamFromModel() {
    return new Team(0, this.nome);
  }

  Coach getCoachFromModel() {
    return new Coach(0, this.nome);
  }

  @override
  String toString() {
    return '$nome' +
        (number != '' ? ' $number' : '') +
        (anno != '' ? ' $anno' : '');
  }

  factory AddFormModel.fromJson(Map<String, dynamic> json) =>
      _$AddFormModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddFormModelToJson(this);
}
