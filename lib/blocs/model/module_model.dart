import 'package:json_annotation/json_annotation.dart';

part 'module_model.g.dart';

@JsonSerializable(nullable: false)
class Module {
  String name;
  List<String> positions;

  Module(this.name, this.positions);
  factory Module.fromJson(Map<String, dynamic> json) => _$ModuleFromJson(json);
  Map<String, dynamic> toJson() => _$ModuleToJson(this);
}
