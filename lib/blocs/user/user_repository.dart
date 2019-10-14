import 'dart:async';
import 'dart:core';

import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'index.dart';

class UserRepository {
  final UserProvider userProvider = new UserProvider();

  Future<Response> newPassword({
    @required String username,
    @required String password,
  }) async {
    var response = await userProvider.newPassword(username, password);
    await Future.delayed(Duration(seconds: 1));
    return response;
  }

  Future<Response> login({
    @required String username,
    @required String password,
  }) async {
    var response = await userProvider.login(username, password);
    await Future.delayed(Duration(seconds: 1));
    return response;
  }

  Future<Response> authenticate(
      {@required String username, @required String mobileNumber}) async {
    var response = await userProvider.askOtp(username, mobileNumber);
    await Future.delayed(Duration(seconds: 1));
    return response;
  }

  Future<Response> authenticateNoAuth(
      {@required String username, @required String mobileNumber}) async {
    var response = await userProvider.askOtpNoAuth(username, mobileNumber);
    await Future.delayed(Duration(seconds: 1));
    return response;
  }

  Future<Response> authenticateUser({@required String otp}) async {
    var response = await userProvider.authenticateUser(otp);
    await Future.delayed(Duration(seconds: 1));
    return response;
  }

  Future<Response> authenticateUserNoAuth({@required String otp}) async {
    var response = await userProvider.authenticateUserNoAuth(otp);
    await Future.delayed(Duration(seconds: 1));
    return response;
  }

  Future<void> deleteKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
    await Future.delayed(Duration(seconds: 1));
  }

  Future<void> persistKey(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    await Future.delayed(Duration(seconds: 1));
  }

  Future<String> readKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key) ?? '';
    return value;
  }

  Future<bool> hasToken() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.getString(key) ?? '';
    if (value != null && value != '') {
      return true;
    }
    await Future.delayed(Duration(seconds: 1));
    return false;
  }
}
