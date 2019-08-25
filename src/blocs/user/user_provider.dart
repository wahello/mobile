import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../const/endpoints.dart';
import 'index.dart';

class UserProvider {
  UserProvider();

  Future<http.Response> login(String username, String password) async {
    http.Response _respAuth = await http.post(Endpoints.loginEndpoint,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {'username': username, 'password': password});
    return _respAuth;
  }

  Future<http.Response> askOtp(String username, String mobileNumber) async {
    final token = await UserRepository().readKey('token');
    http.Response _respAuth =
        await http.post(Endpoints.askOtpEndpoint, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      HttpHeaders.authorizationHeader: token
    }, body: {
      'username': username,
      'mobileNumber': mobileNumber
    });
    return _respAuth;
  }

  Future<http.Response> authenticateUser(String otp) async {
    final token = await UserRepository().readKey('token');
    http.Response _respAuth =
        await http.post(Endpoints.confirmOtpEndpoint, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      HttpHeaders.authorizationHeader: token
    }, body: {
      'otp': otp
    });
    return _respAuth;
  }
}
