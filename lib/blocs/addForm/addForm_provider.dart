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

  Future<http.Response> sendData(List<AddFormModel> dataToSend,
      TypeAddForm type, String categoryId, String teamId) async {
    String endpoint;
    Map<String, String> body = new Map();
    switch (type) {
      case TypeAddForm.TEAM:
        body = {'name': dataToSend[0].nome};
        endpoint = Endpoints.domain +
            Endpoints.categories +
            '/' +
            categoryId +
            Endpoints.submitTeam;
        break;
      case TypeAddForm.PLAYER:
        body = {
          'name': dataToSend[0].nome,
          'number': dataToSend[0].number,
          'year': dataToSend[0].anno
        };
        endpoint = Endpoints.domain +
            Endpoints.teams +
            '/' +
            teamId +
            Endpoints.submitPlayer;
        break;
      case TypeAddForm.COACH:
        body = {'name': dataToSend[0].nome};
        endpoint = Endpoints.domain +
            Endpoints.teams +
            '/' +
            teamId +
            Endpoints.submitCoach;
        break;
      default:
        throw new HttpException('Missing url');
    }
    final token = await CallsRepository().readKey('token');
    try {
      http.Response _resp = await http.post(endpoint,
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            HttpHeaders.authorizationHeader: token
          },
          body: body);
      return _resp;
    } catch (error) {
      print(error);
    }
    return null;
  }
}
