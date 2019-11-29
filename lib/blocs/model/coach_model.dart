import 'package:json_annotation/json_annotation.dart';

part 'coach_model.g.dart';

@JsonSerializable(nullable: false)
class Coach {
  int id;
  String name;

  Coach(this.id, this.name);

  factory Coach.fromJson(Map<String, dynamic> json) => _$CoachFromJson(json);
  Map<String, dynamic> toJson() => _$CoachToJson(this);
}
