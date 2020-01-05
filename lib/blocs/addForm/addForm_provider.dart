import 'dart:async';

import 'package:football_system/blocs/stuff/calls_repository.dart';
import 'package:http/http.dart' as http;

class AddFormProvider {
  static final AddFormProvider _addFormProvider = AddFormProvider._internal();
  factory AddFormProvider() {
    return _addFormProvider;
  }
  AddFormProvider._internal();

  Future<http.Response> sendData(List dataToSend) async {
    //TODO definire endpoint
    final token = await CallsRepository().readKey('token');
    http.Response _respAuth;
    return _respAuth;
  }
}
