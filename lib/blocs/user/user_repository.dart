import 'dart:async';
import 'dart:core';

import 'package:http/http.dart';
import 'package:meta/meta.dart';

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
}
