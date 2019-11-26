import 'package:json_annotation/json_annotation.dart';

part 'championship_model.g.dart';

@JsonSerializable(nullable: false)
class Championship {
  int id;
  String name;

  Championship(this.id, this.name);
  factory Championship.fromJson(Map<String, dynamic> json) =>
      _$ChampionshipFromJson(json);
  Map<String, dynamic> toJson() => _$ChampionshipToJson(this);
}
