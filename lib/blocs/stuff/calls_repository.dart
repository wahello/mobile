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
    final response = await callsProvider.genders();
    return response;
  }

  Future<dynamic> getChampionships() async {
    final response = await callsProvider.championships();
    return response;
  }

  Future<dynamic> getMatches(String championshipId) async {
    final response = await callsProvider.matches(championshipId);
    return response;
  }

  Future<dynamic> getCategories(
      String genderId, String championshipId, String matchId) async {
    final response =
        await callsProvider.categories(genderId, championshipId, matchId);
    return response;
  }

  Future<dynamic> getTournaments(String inputTextValue) async {
    final response = await callsProvider.tournaments(inputTextValue);
    return response;
  }

  Future<dynamic> getTeams(String categoryId) async {
    final response = await callsProvider.teams(categoryId);
    return response;
  }

  Future<dynamic> getCoaches(String teamId) async {
    final response = await callsProvider.coaches(teamId);
    return response;
  }

  Future<dynamic> getPlayers(String teamId) async {
    final response = await callsProvider.players(teamId);
    return response;
  }

  Future<dynamic> getTactics(String categoryId) async {
    final response = await callsProvider.tactics(categoryId);
    return response;
  }
}
