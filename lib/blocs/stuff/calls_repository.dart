import 'dart:convert';

import 'package:football_system/blocs/stuff/calls_model.dart';
import 'package:football_system/blocs/stuff/calls_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CallsRepository {
  final CallsProvider callsProvider = new CallsProvider();

  Future<void> deleteKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
    await Future.delayed(Duration(seconds: 1));
  }

  Future<void> persistKey(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is String) {
      prefs.setString(key, value);
    }
    if (value is List<String>) {
      prefs.setStringList(key, value);
    }
    if (value is int) {
      prefs.setInt(key, value);
    }
    if (value is double) {
      prefs.setDouble(key, value);
    }
    if (value is bool) {
      prefs.setBool(key, value);
    }
    await Future.delayed(Duration(seconds: 1));
  }

  Future<dynamic> readKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final value = prefs.get(key) ?? '';
    return value;
  }

  Future<bool> hasToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.getString(key) ?? '';
    if (value != null && value != '') {
      return true;
    }
    await Future.delayed(Duration(seconds: 1));
    return false;
  }

  Future<dynamic> getGenders() async {
    var response;
    var genders;
    response = await callsProvider.genders();
    if (response.statusCode == 200 && response.reasonPhrase == 'OK') {
      var list = jsonDecode(response.body) as List;
      List<Gender> genderList =
          list.map((gender) => Gender.fromJson(gender)).toList();
      genders = genderList;
    }
    await Future.delayed(Duration(seconds: 1));
    return genders;
  }

  Future<dynamic> getChampionships() async {
    var response;
    var championships;
    response = await callsProvider.championships();
    if (response.statusCode == 200 && response.reasonPhrase == 'OK') {
      var list = jsonDecode(response.body) as List;
      List<Championship> championshipsList = list
          .map((championship) => Championship.fromJson(championship))
          .toList();
      championships = championshipsList;
    }
    await Future.delayed(Duration(seconds: 1));
    return championships;
  }

  Future<dynamic> getMatches(String championshipId) async {
    var response;
    var matches;
    response = await callsProvider.matches(championshipId);
    if (response.statusCode == 200 && response.reasonPhrase == 'OK') {
      var list = jsonDecode(response.body) as List;
      List<Match> matchesList =
          list.map((match) => Match.fromJson(match)).toList();
      matches = matchesList;
    }
    await Future.delayed(Duration(seconds: 1));
    return matches;
  }

  Future<dynamic> getCategories(
      String genderId, String championshipId, String matchId) async {
    var response;
    var categories;
    response =
        await callsProvider.categories(genderId, championshipId, matchId);
    if (response.statusCode == 200 && response.reasonPhrase == 'OK') {
      var list = jsonDecode(response.body) as List;
      List<Category> categoriesList =
          list.map((match) => Category.fromJson(match)).toList();
      categories = categoriesList;
    }
    await Future.delayed(Duration(seconds: 1));
    return categories;
  }

  Future<dynamic> getTeams(String categoryId) async {
    var response;
    var teams = await readKey('teams');
    if (teams.isEmpty) {
      response = await callsProvider.teams(categoryId);
      teams = jsonDecode(response.body);
      persistKey('teams', teams);
    }
    await Future.delayed(Duration(seconds: 1));
    return teams;
  }

  Future<dynamic> getCoaches(String teamId) async {
    var response;
    var coaches = await readKey('coaches');
    if (coaches.isEmpty) {
      response = await callsProvider.coaches(teamId);
      coaches = jsonDecode(response.body);
      persistKey('coaches', coaches);
    }
    await Future.delayed(Duration(seconds: 1));
    return coaches;
  }

  Future<dynamic> getPlayers(String teamId) async {
    var response;
    var players = await readKey('players');
    if (players.isEmpty) {
      response = await callsProvider.players(teamId);
      players = jsonDecode(response.body);
      persistKey('players', players);
    }
    await Future.delayed(Duration(seconds: 1));
    return players;
  }

  Future<dynamic> getTactics(String categoryId) async {
    var response;
    var tactics = await readKey('tactics');
    if (tactics.isEmpty) {
      response = await callsProvider.tactics(categoryId);
      tactics = jsonDecode(response.body);
      persistKey('tactics', tactics);
    }
    await Future.delayed(Duration(seconds: 1));
    return tactics;
  }
}
