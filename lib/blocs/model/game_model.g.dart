// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) {
  return Game(
    (json['teamHome'] as List)
        .map((e) => Incontro.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['teamAway'] as List)
        .map((e) => Incontro.fromJson(e as Map<String, dynamic>))
        .toList(),
  )..name = json['name'] as String;
}

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'teamHome': instance.teamHome.map((incontro) => incontro.toJson()),
      'teamAway': instance.teamAway.map((incontro) => incontro.toJson()),
      'name': instance.name,
    };
