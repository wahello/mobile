import 'package:json_annotation/json_annotation.dart';

part 'match_model.g.dart';

@JsonSerializable(nullable: false)
class Partita {
  int id;
  String name;

  Partita(this.id, this.name);
  factory Partita.fromJson(Map<String, dynamic> json) =>
      _$PartitaFromJson(json);
  Map<String, dynamic> toJson() => _$PartitaToJson(this);
}
