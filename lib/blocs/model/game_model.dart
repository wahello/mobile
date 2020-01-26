import 'package:json_annotation/json_annotation.dart';
import 'incontro_model.dart';

part 'game_model.g.dart';

@JsonSerializable(nullable: false)
class Game {
  List<Incontro> teamHome;
  List<Incontro> teamAway;

  String name;

  Game(this.teamHome, this.teamAway);
  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
  Map<String, dynamic> toJson() => _$GameToJson(this);
}
