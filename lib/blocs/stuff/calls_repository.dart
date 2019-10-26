import 'dart:convert';

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
    var genders = await readKey('genders');
    if (genders.isEmpty) {
      response = await callsProvider.genders();
      genders = jsonDecode(response.body);
      persistKey('genders', genders);
    }
    await Future.delayed(Duration(seconds: 1));
    return genders;
  }

  Future<dynamic> getChampionships() async {
    var response;
    var championships = await readKey('championships');
    if (championships.isEmpty) {
      response = await callsProvider.championships();
      championships = jsonDecode(response.body);
      persistKey('championships', championships);
    }
    await Future.delayed(Duration(seconds: 1));
    return championships;
  }

  Future<dynamic> getMatches(String championshipId) async {
    var response;
    var matches = await readKey('matches');
    if (matches.isEmpty) {
      response = await callsProvider.matches(championshipId);
      matches = jsonDecode(response.body);
      persistKey('matches', matches);
    }
    await Future.delayed(Duration(seconds: 1));
    return matches;
  }

  Future<dynamic> getCategories(String matchId, String genderId) async {
    var response;
    var categories = await readKey('categories');
    if (categories.isEmpty) {
      response = await callsProvider.categories(matchId, genderId);
      categories = jsonDecode(response.body);
      persistKey('categories', categories);
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
