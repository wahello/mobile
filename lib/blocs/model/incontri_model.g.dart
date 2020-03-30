// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incontri_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Incontri _$IncontriFromJson(Map<String, dynamic> json) {
  return Incontri(
    Incontro.fromJson(json['home'] as Map<String, dynamic>),
    Incontro.fromJson(json['away'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$IncontriToJson(Incontri instance) => <String, dynamic>{
      'home': instance.home,
      'away': instance.away,
    };
