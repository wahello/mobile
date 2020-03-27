// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addFormModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddFormModel _$AddFormModelFromJson(Map<String, dynamic> json) {
  return AddFormModel(
    nome: json['nome'] as String,
    number: json['number'] as String,
    anno: json['anno'] as String,
  );
}

Map<String, dynamic> _$AddFormModelToJson(AddFormModel instance) =>
    <String, dynamic>{
      'nome': instance.nome,
      'number': instance.number,
      'anno': instance.anno,
    };
