import 'dart:async';
import 'dart:io';

import 'package:football_system/blocs/stuff/calls_repository.dart';
import 'package:http/http.dart' as http;
import 'package:shared/shared.dart';

class FootballFieldProvider {
  FootballFieldProvider();

  Future<http.Response> getModules() async {
    http.Response _respAuth = await http.get(Endpoints.modules,
        headers: {"Content-Type": "application/x-www-form-urlencoded"});
    return _respAuth;
  }
}
