// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) {
  return Player(
    number: json['number'] as String,
    id: json['id'] as int,
    name: json['name'] as String,
    ruolo: json['ruolo'] as String,
    posizione: json['posizione'] as String,
    redCard: json['redCard'],
    yellowCard: json['yellowCard'],
    assist: json['assist'],
    goal: json['goal'],
  )..note = json['note'] as String;
}

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'notes': instance.notes,
      'id': instance.id,
      'name': instance.name,
      'ruolo': instance.ruolo,
      'numero': instance.number,
      'posizione': instance.posizione,
      'redCard': instance.redCard,
      'yellowCard': instance.yellowCard,
      'goal': instance.goal,
      'assist': instance.assist,
    };
