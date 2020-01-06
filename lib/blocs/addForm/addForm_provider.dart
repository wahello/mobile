import 'dart:async';
import 'dart:io';

import 'package:football_system/blocs/addForm/addFormSingleInstance.dart';
import 'package:football_system/blocs/stuff/calls_repository.dart';
import 'package:http/http.dart' as http;
import 'package:shared/shared.dart';

class AddFormProvider {
  static final AddFormProvider _addFormProvider = AddFormProvider._internal();
  factory AddFormProvider() {
    return _addFormProvider;
  }
  AddFormProvider._internal();

  Future<http.Response> sendData(
      List dataToSend, TypeAddForm type, String id) async {
    String endpoint;
    switch (type) {
      case TypeAddForm.TEAM:
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
        body: dataToSend);
    return _resp;
  }
}
