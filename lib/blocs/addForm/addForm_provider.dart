import 'dart:async';
import 'dart:io';

import 'package:football_system/blocs/addForm/addFormSingleInstance.dart';
import 'package:football_system/blocs/stuff/calls_repository.dart';
import 'package:http/http.dart' as http;
import 'package:shared/shared.dart';

import 'addFormModel.dart';

class AddFormProvider {
  static final AddFormProvider _addFormProvider = AddFormProvider._internal();
  factory AddFormProvider() {
    return _addFormProvider;
  }
  AddFormProvider._internal();

  Future<http.Response> sendData(
      List<AddFormModel> dataToSend, TypeAddForm type, String id) async {
    String endpoint;
    List dataConverted;
    switch (type) {
      case TypeAddForm.TEAM:
        for (var d in dataToSend) {
          dataConverted.add(d.getTeamFromModel());
        }
        endpoint = Endpoints.domain +
            Endpoints.categories +
            id +
            '/' +
            Endpoints.submitTeam;
        break;
      case TypeAddForm.PLAYER:
        for (var d in dataToSend) {
          dataConverted.add(d.getPlayerFromModel());
        }
        endpoint = Endpoints.domain +
            Endpoints.categories +
            id +
            '/' +
            Endpoints.submitTeam;
        break;
      case TypeAddForm.COACH:
        for (var d in dataToSend) {
          dataConverted.add(d.getCoachFromModel());
        }
        endpoint = Endpoints.domain +
            Endpoints.categories +
            id +
            '/' +
            Endpoints.submitTeam;
        break;
      default:
        throw new HttpException('Missing url');
    }
    final token = await CallsRepository().readKey('token');
    http.Response _resp = await http.post(endpoint,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          HttpHeaders.authorizationHeader: token
        },
        body: dataConverted);
    return _resp;
  }
}
