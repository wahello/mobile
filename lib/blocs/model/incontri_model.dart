import 'package:football_system/blocs/model/incontro_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'incontri_model.g.dart';

@JsonSerializable(nullable: false)
class Incontri {
  Incontro home;
  Incontro away;

  Incontri(this.home, this.away);

  factory Incontri.fromJson(Map<String, dynamic> json) =>
      _$IncontriFromJson(json);
  Map<String, dynamic> toJson() => _$IncontriToJson(this);
}
