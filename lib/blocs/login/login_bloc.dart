import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared/shared.dart';

import '../authentication/authentication_bloc.dart';
import '../authentication/index.dart';
import '../user/user_repository.dart';
import 'index.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  }) : assert(userRepository != null && authenticationBloc != null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final response = await userRepository.login(
          username: event.username,
          password: event.password,
        );

        if (response.reasonPhrase == 'OK') {
          userRepository.persistKey('username', event.username);
          Map tokenMap = jsonDecode(response.body);
          var token = Token.fromJson(tokenMap);
          await userRepository.persistKey('token', token.token);
          authenticationBloc.dispatch(OTP(token: token.token));
          yield OTPInitial();
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
        final username = await userRepository.readKey('username');
        final response = await userRepository.authenticate(
            username: username, mobileNumber: event.mobileNumber);
        if (response.reasonPhrase == 'OK') {
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
        final response = await userRepository.authenticateUser(otp: event.otp);
        if (response.reasonPhrase == 'OK') {
          authenticationBloc.dispatch(LoggedIn());
          yield LoginInitial();
        } else {
          yield LoginFailure(
              error: jsonDecode(response.reasonPhrase).toString());
        }
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
