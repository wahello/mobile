import 'package:json_annotation/json_annotation.dart';

part 'player_model.g.dart';

@JsonSerializable(nullable: false)
class Player {
  //TODO : verificare se i nuovi campi hanno effetto nei json di risposta

  String note;
  final int id;
  final String name;
  String ruolo;
  String numero;
  String posizione;
  Player({this.id, this.name, this.ruolo, this.posizione});
  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerToJson(this);
}
