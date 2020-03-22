import 'dart:async';
import 'dart:convert';
import 'dart:collection';
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
    Map body = new Map();

    String header = "application/x-www-form-urlencoded";
    //per retrocompatibilità usiamo questa variabile per abilitare le chiamate che (non)usano json
    bool isJson = false;

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
        List players = new List();
        for (AddFormModel player in dataToSend) {
          Map<String, String> toAdd = new Map();
          toAdd.putIfAbsent('name', () => player.nome);
          toAdd.putIfAbsent('number', () => player.number);
          toAdd.putIfAbsent('year', () => player.anno);
          players.add(toAdd);
        }
        body.putIfAbsent('players', () => players);
        isJson = true;
        header = "application/json";
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
            "Content-Type": header,
            HttpHeaders.authorizationHeader: token
          },
          body: isJson ? json.encode(body) : body);
      return _resp;
    } catch (error) {
      print(error);
    }
    return null;
  }
}
