import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {}

class AuthenticationUninitialized extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUninitialized';
}

class AuthenticationAuthenticated extends AuthenticationState {
  @override
  String toString() => 'AuthenticationAuthenticated';
}

class BackedToHomeFromButton extends AuthenticationState {
  @override
  String toString() => 'BackedToHomeFromButton';
}

class InserimentoPageSelected extends AuthenticationState {
  @override
  String toString() => 'InserimentoPageSelected';
}

class AuthenticationUnauthenticated extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUnauthenticated';
}

class AuthenticationLoading extends AuthenticationState {
  @override
  String toString() => 'AuthenticationLoading';
}

class OTPRequired extends AuthenticationState {
  @override
  String toString() => 'OTPRequired';
}
