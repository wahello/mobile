// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incontro_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Incontro _$IncontroFromJson(Map<String, dynamic> json) {
  return Incontro(
    Gender.fromJson(json['gender'] as Map<String, dynamic>),
    Category.fromJson(json['category'] as Map<String, dynamic>),
    Championship.fromJson(json['championship'] as Map<String, dynamic>),
    Partita.fromJson(json['match'] as Map<String, dynamic>),
    Tournament.fromJson(json['tournament'] as Map<String, dynamic>),
    Team.fromJson(json['team'] as Map<String, dynamic>),
    (json['players'] as List)
        .map((e) => Player.fromJson(e as Map<String, dynamic>))
        .toList(),
    Coach.fromJson(json['coach'] as Map<String, dynamic>),
  )..module = Module.fromJson(json['module'] as Map<String, dynamic>);
}

Map<String, dynamic> _$IncontroToJson(Incontro instance) => <String, dynamic>{
      'gender': instance.gender,
      'category': instance.category,
      'championship': instance.championship,
      'match': instance.match,
      'tournament': instance.tournament,
      'team': instance.team,
      'players': instance.players,
      'coach': instance.coach,
      'module': instance.module,
    };
