import 'package:json_annotation/json_annotation.dart';

part 'lovGenericObject_model.g.dart';

@JsonSerializable(nullable: false)
class LovGenericObject {
  String key;
  String value;

  LovGenericObject(this.key, this.value);
  factory LovGenericObject.fromJson(Map<String, dynamic> json) =>
      _$LovGenericObjectFromJson(json);
  Map<String, dynamic> toJson() => _$LovGenericObjectToJson(this);
}
