import 'package:json_annotation/json_annotation.dart';

part 'module_model.g.dart';

@JsonSerializable()
class Module {
  int id;
  String createdAt;
  String updatedAt;
  String deletedAt;
  String name;
  List<List<String>> positions;
  int profileId;

  Module(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.positions,
      this.profileId});

  factory Module.fromJson(Map<String, dynamic> json) => _$ModuleFromJson(json);

  Map<String, dynamic> toJson() => _$ModuleToJson(this);
}
