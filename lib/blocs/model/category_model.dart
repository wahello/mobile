import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable(nullable: false)
class Category {
  int id;
  String name;
  int profileId;

  Category(this.id, this.name);
  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
