import 'package:json_annotation/json_annotation.dart';

part 'tournament_model.g.dart';

@JsonSerializable(nullable: false)
class Tournament {
  int id;
  String name;

  Tournament(this.id, this.name);
  factory Tournament.fromJson(Map<String, dynamic> json) =>
      _$TournamentFromJson(json);
  Map<String, dynamic> toJson() => _$TournamentToJson(this);
}
