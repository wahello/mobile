// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playerRequest_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerRequest _$PlayerRequestFromJson(Map<String, dynamic> json) {
  return PlayerRequest(
    (json['players'] as List)
        ?.map((e) =>
            e == null ? null : AddFormModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PlayerRequestToJson(PlayerRequest instance) =>
    <String, dynamic>{
      'players': instance.players,
    };
