import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:football_system/blocs/stuff/calls_repository.dart';
import 'package:meta/meta.dart';
import 'package:shared/shared.dart';

import '../authentication/authentication_bloc.dart';
import '../authentication/index.dart';
import '../user/user_repository.dart';
import 'index.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;
  final CallsRepository callsRepository;

  LoginBloc({
    @required this.userRepository,
    @required this.callsRepository,
    @required this.authenticationBloc,
  }) : assert(userRepository != null &&
            authenticationBloc != null &&
            callsRepository != null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        await callsRepository.persistKey('username', event.username);
        final response = await userRepository.login(
          username: event.username,
          password: event.password,
        );

        if (response.statusCode == 200 && response.reasonPhrase == 'OK') {
          Map tokenMap = jsonDecode(response.body);
          var token = Token.fromJson(tokenMap);
          await callsRepository.persistKey('token', 'Bearer ' + token.token);
          // TODO: ripristinare OTP
          authenticationBloc.add(LoggedIn());
          // authenticationBloc.add(OTP(token: token.token));
          // yield OTPInitial();
        } else {
          yield LoginFailure(
              error: jsonDecode(response.reasonPhrase).toString());
        }
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
    if (event is OtpPageLoaded) {
      yield LoginLoading();

      try {
        final username = await callsRepository.readKey('username');
        var response;
        final newpassword = await callsRepository.readKey('newpassword');
        if (newpassword.isNotEmpty) {
          response = await userRepository.authenticateNoAuth(
              username: username, mobileNumber: event.mobileNumber);
        } else {
          response = await userRepository.authenticate(
              username: username, mobileNumber: event.mobileNumber);
        }
        if (response.statusCode == 200 && response.reasonPhrase == 'OK') {
          yield OTPInitial();
        } else {
          yield LoginFailure(
              error: jsonDecode(response.reasonPhrase).toString());
        }
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
    if (event is OtpButtonPressed) {
      yield LoginLoading();
      try {
        final newpassword = await callsRepository.readKey('newpassword');
        var response;
        if (newpassword.isNotEmpty) {
          response =
              await userRepository.authenticateUserNoAuth(otp: event.otp);
        } else {
          response = await userRepository.authenticateUser(otp: event.otp);
        }
        if (response.statusCode == 200 && response.reasonPhrase == 'OK') {
          if (newpassword.isNotEmpty) {
            final username = await callsRepository.readKey('username');
            final reset = await userRepository.newPassword(
                username: username, password: newpassword);
            if (reset.reasonPhrase == 'OK') {
              await callsRepository.deleteKey('newpassword');
              authenticationBloc.add(LoggedIn());
              yield LoginInitial();
            } else {
              yield LoginFailure(
                  error: jsonDecode(response.reasonPhrase).toString());
            }
          } else {
            authenticationBloc.add(LoggedIn());
            yield LoginInitial();
          }
        } else {
          yield LoginFailure(
              error: jsonDecode(response.reasonPhrase).toString());
        }
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
    if (event is ForgotPasswordButtonPressed) {
      yield LoginLoading();
      try {
        await callsRepository.persistKey('username', event.username);
        await callsRepository.persistKey('newpassword', event.password);
        var token = await callsRepository.readKey('token');
        // TODO: ripristinare OTP
        authenticationBloc.add(LoggedIn());
        // authenticationBloc.add(OTP(token: token));
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
