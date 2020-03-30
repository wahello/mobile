import 'package:json_annotation/json_annotation.dart';

part 'player_model.g.dart';

@JsonSerializable(nullable: false)
class Player {
  //TODO : verificare se i nuovi campi hanno effetto nei json di risposta

  String note;
  final int id;
  String name;
  String ruolo;
  String number;
  String posizione;
  String anno;
  String test;
  //#cartellino giallo
  int yellowCard;
  //#cartellino rosso
  int redCard;
  //#goal
  int goal;
  //#assist
  var assist = 0;

  List<String> notes = [""].toList();

  Player(
      {this.number, this.id, this.name, this.ruolo, this.posizione, this.anno});
  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerToJson(this);
}
