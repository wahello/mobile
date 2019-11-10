import 'package:football_system/blocs/stuff/category_model.dart';
import 'package:football_system/blocs/stuff/championship_model.dart';
import 'package:football_system/blocs/stuff/gender_model.dart';
import 'package:football_system/blocs/stuff/match_model.dart';
import 'package:football_system/blocs/stuff/team_model.dart';
import 'package:football_system/blocs/stuff/tournament_model.dart';

class Incontro {
  Gender gender;
  Category category;
  Championship championship;
  Match match;
  Tournament tournament;
  Team team;

  Incontro(this.gender, this.category, this.championship, this.match,
      this.tournament, this.team);

  Incontro.fromJson(Map<String, dynamic> json) {
    this.gender = Gender.fromJson(json['gender']) ?? null;
    this.category = Category.fromJson(json['category']) ?? null;
    this.championship = Championship.fromJson(json['championship']) ?? null;
    this.match = Match.fromJson(json['match']) ?? null;
    this.tournament = Tournament.fromJson(json['tournament']) ?? null;
    this.team = Team.fromJson(json['team']) ?? null;
  }

  Map<String, dynamic> toJson() => {
        'gender': new Gender(this.gender.id, this.gender.name) ?? null,
        'category': new Category(this.category.id, this.category.name) ?? null,
        'championship':
            new Championship(this.championship.id, this.championship.name) ??
                null,
        'match': new Match(this.match.id, this.match.name) ?? null,
        'tournament':
            new Tournament(this.tournament.id, this.tournament.name) ?? null,
        'team': new Team(this.team.id, this.team.name) ?? null,
      };
}
