import 'package:football_system/blocs/model/coach_model.dart';
import 'package:football_system/blocs/model/player_model.dart';
import 'package:football_system/blocs/model/team_model.dart';

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
}
