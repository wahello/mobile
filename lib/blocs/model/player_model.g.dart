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
    anno: json['anno'] as String,
  )
    ..note = json['note'] as String
    ..test = json['test'] as String
    ..yellowCard = json['yellowCard'] as int
    ..redCard = json['redCard'] as int
    ..goal = json['goal'] as int
    ..assist = json['assist'] as int
    ..notes = json['notes'] != null
        ? (json['notes'] as List).map((e) => e as String).toList()
        : List();
}

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'note': instance.note,
      'id': instance.id,
      'name': instance.name,
      'ruolo': instance.ruolo,
      'number': instance.number,
      'posizione': instance.posizione,
      'anno': instance.anno,
      'test': instance.test,
      'yellowCard': instance.yellowCard,
      'redCard': instance.redCard,
      'goal': instance.goal,
      'assist': instance.assist,
      'notes': instance.notes,
    };
