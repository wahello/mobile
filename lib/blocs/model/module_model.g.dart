// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Module _$ModuleFromJson(Map<String, dynamic> json) {
  return Module(
    json['name'] as String,
    (json['positions'] as List).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$ModuleToJson(Module instance) => <String, dynamic>{
      'name': instance.name,
      'positions': instance.positions,
    };
