import 'dart:async';
import 'dart:io';

import 'package:football_system/blocs/stuff/calls_repository.dart';
import 'package:http/http.dart' as http;

class FootballFieldProvider {
  FootballFieldProvider();

  Future<http.Response> getModules() async {
    final token = await CallsRepository().readKey('token');
    http.Response _respAuth = await http.get('Endpoints.modules', headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      HttpHeaders.authorizationHeader: token
    });
    return _respAuth;
  }
}
