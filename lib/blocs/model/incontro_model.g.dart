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
      'gender': instance.gender.toJson(),
      'category': instance.category.toJson(),
      'championship': instance.championship.toJson(),
      'match': instance.match.toJson(),
      //FIXME: tournament è null, capire perchè
      // 'tournament': instance.tournament.toJson(),
      'team': instance.team.toJson(),
      'players': instance.players.map((player) => player.toJson()),
      'coach': instance.coach.toJson(),
      'module': instance.module.toJson(),
    };
