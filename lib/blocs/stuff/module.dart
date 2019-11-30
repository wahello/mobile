import 'package:json_annotation/json_annotation.dart';

part 'module.g.dart';

@JsonSerializable
class Module {
  //ARRAY CHE CONTIENE LE POSIZIONI DEI GIOCATORI NELLA "SCACCHIERA".
  final List<String> fieldPostions;
  //NOME DEL MODULO. ES:4-4-2
  final String name;

  Module({this.fieldPostions, this.name});

  factory Module.fromJson(Map<String, dynamic> json) => _$ModuleFromJson(json);

  Map<String, dynamic> toJson() => _$ModuleToJson(this);
}
