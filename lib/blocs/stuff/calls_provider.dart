import 'dart:async';
import 'dart:io';

import 'package:football_system/blocs/stuff/calls_repository.dart';
import 'package:http/http.dart' as http;
import 'package:shared/shared.dart';

class CallsProvider {
  static final CallsProvider _callsProvider = CallsProvider._internal();
  factory CallsProvider() {
    return _callsProvider;
  }
  CallsProvider._internal();

  Future<http.Response> genders() async {
    final token = await CallsRepository().readKey('token');
    http.Response _respAuth =
        await http.get(Endpoints.domain + Endpoints.genders, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      HttpHeaders.authorizationHeader: token
    });
    return _respAuth;
  }

  Future<http.Response> championships() async {
    final token = await CallsRepository().readKey('token');
    http.Response _respAuth =
        await http.get(Endpoints.domain + Endpoints.championships, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      HttpHeaders.authorizationHeader: token
    });
    return _respAuth;
  }

  Future<http.Response> matches(String championshipId) async {
    final token = await CallsRepository().readKey('token');
    http.Response _respAuth = await http.get(
        Endpoints.domain +
            Endpoints.championships +
            '/' +
            championshipId +
            Endpoints.matches,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          HttpHeaders.authorizationHeader: token
        });
    return _respAuth;
  }

  Future<http.Response> categories(
      String genderId, String championshipId, String matchId) async {
    final token = await CallsRepository().readKey('token');
    http.Response _respAuth = await http.get(
        Endpoints.domain +
            Endpoints.genders +
            '/' +
            genderId +
            Endpoints.championships +
            '/' +
            championshipId +
            Endpoints.matches +
            '/' +
            matchId +
            Endpoints.categories,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          HttpHeaders.authorizationHeader: token
        });
    return _respAuth;
  }

  Future<http.Response> tournaments(String inputTextValue) async {
    final token = await CallsRepository().readKey('token');
    http.Response _respAuth =
        await http.get(Endpoints.domain + Endpoints.tournaments, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      HttpHeaders.authorizationHeader: token
    });
    return _respAuth;
  }

  Future<http.Response> teams(String categoryId) async {
    final token = await CallsRepository().readKey('token');
    http.Response _respAuth = await http.get(
        Endpoints.domain +
            Endpoints.categories +
            '/' +
            categoryId +
            Endpoints.teams,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          HttpHeaders.authorizationHeader: token
        });
    return _respAuth;
  }

  Future<http.Response> players(String teamId) async {
    final token = await CallsRepository().readKey('token');
    http.Response _respAuth = await http.get(
        Endpoints.domain + Endpoints.teams + "/" + teamId + Endpoints.players,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          HttpHeaders.authorizationHeader: token
        });
    return _respAuth;
  }

  Future<http.Response> coaches(String teamId) async {
    final token = await CallsRepository().readKey('token');
    http.Response _respAuth = await http.get(
        Endpoints.domain + Endpoints.teams + "/" + teamId + Endpoints.coaches,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          HttpHeaders.authorizationHeader: token
        });
    return _respAuth;
  }

  Future<http.Response> tactics(String categoryId) async {
    final token = await CallsRepository().readKey('token');
    http.Response _respAuth = await http.get(
        Endpoints.domain +
            Endpoints.profiles +
            "/" +
            "4" +
            Endpoints.tactics,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          HttpHeaders.authorizationHeader: token
        });
    return _respAuth;
  }
}
