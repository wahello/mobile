// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) {
  return Player(
    id: json['id'] as int,
    name: json['name'] as String,
    ruolo: json['ruolo'] as String,
    posizione: json['posizione'] as String,
  )
    ..note = json['note'] as String
    ..numero = json['numero'] as String;
}

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'note': instance.note,
      'id': instance.id,
      'name': instance.name,
      'ruolo': instance.ruolo,
      'numero': instance.numero,
      'posizione': instance.posizione,
    };