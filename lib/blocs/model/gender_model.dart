import 'package:json_annotation/json_annotation.dart';

part 'gender_model.g.dart';

@JsonSerializable(nullable: false)
class Gender {
  int id;
  String name;

  Gender(this.id, this.name);
  factory Gender.fromJson(Map<String, dynamic> json) => _$GenderFromJson(json);
  Map<String, dynamic> toJson() => _$GenderToJson(this);
}
