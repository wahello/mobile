import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);
}

class Splash extends AuthenticationEvent {
  @override
  String toString() => 'Splash';
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthenticationEvent {
  @override
  String toString() => 'LoggedIn';
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}

class OTP extends AuthenticationEvent {
  final String token;

  OTP({@required this.token}) : super([token]);

  @override
  String toString() => 'OTP { token: $token }';
}
