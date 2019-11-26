import 'package:json_annotation/json_annotation.dart';

part 'team_model.g.dart';

@JsonSerializable(nullable: false)
class Team {
  int id;
  String name;

  Team(this.id, this.name);
  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
  Map<String, dynamic> toJson() => _$TeamToJson(this);
}
