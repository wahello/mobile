import 'package:football_system/blocs/model/addFormModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'playerRequest_model.g.dart';

@JsonSerializable()
class PlayerRequest {
  PlayerRequest(this.players);

  List<AddFormModel> players;

  factory PlayerRequest.fromJson(Map<String, dynamic> json) =>
      _$PlayerRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerRequestToJson(this);
}
