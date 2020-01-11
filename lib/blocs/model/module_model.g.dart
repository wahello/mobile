// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Module _$ModuleFromJson(Map<String, dynamic> json) {
  List<List<String>> _positions = List.generate(
      json['positions'].length, (_) => List.generate(1, (_) => ""));

  for (int i = 0; i < json['positions'].length; i++) {
    _positions[i][0] = json['positions'][i][0].toString();
  }
  print(_positions);
  return Module(
    id: json['id'] as int,
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
    name: json['name'].toString(),
    positions: _positions,
    profileId: json['profileId'] as int,
  )..deletedAt = json['deletedAt'] as String;
}

Map<String, dynamic> _$ModuleToJson(Module instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'deletedAt': instance.deletedAt,
      'name': instance.name,
      'positions': instance.positions,
      'profileId': instance.profileId,
    };
