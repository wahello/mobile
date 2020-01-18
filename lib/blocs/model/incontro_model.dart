import 'package:football_system/blocs/model/category_model.dart';
import 'package:football_system/blocs/model/championship_model.dart';
import 'package:football_system/blocs/model/coach_model.dart';
import 'package:football_system/blocs/model/gender_model.dart';
import 'package:football_system/blocs/model/match_model.dart';
import 'package:football_system/blocs/model/module_model.dart';
import 'package:football_system/blocs/model/player_model.dart';
import 'package:football_system/blocs/model/team_model.dart';
import 'package:football_system/blocs/model/tournament_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'incontro_model.g.dart';

@JsonSerializable(nullable: false)
class Incontro {
  Gender gender;
  Category category;
  Championship championship;
  Partita match;
  Tournament tournament;
  Team teamHome;
  Team teamAway;
  List<Player> playersHome;
  Coach coachHome;
  Module moduleHome;
  List<Player> playersAway;
  Coach coachAway;
  Module moduleAway;

  Incontro(this.gender, this.category, this.championship, this.match,
      this.tournament, this.teamHome, this.playersHome, this.coachHome, this.teamAway, this.playersAway, this.coachAway);
  factory Incontro.fromJson(Map<String, dynamic> json) =>
      _$IncontroFromJson(json);
  Map<String, dynamic> toJson() => _$IncontroToJson(this);
}
