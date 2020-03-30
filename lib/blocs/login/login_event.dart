import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  LoginButtonPressed({
    @required this.username,
    @required this.password,
  }) : super([username, password]);

  @override
  String toString() =>
      'LoginButtonPressed { username: $username, password: $password }';
}

class OtpButtonPressed extends LoginEvent {
  final String otp;

  OtpButtonPressed({
    @required this.otp,
  }) : super([otp]);

  @override
  String toString() => 'OtpButtonPressed { otp: $otp }';
}

class OtpPageLoaded extends LoginEvent {
  final String mobileNumber;

  OtpPageLoaded({
    @required this.mobileNumber,
  }) : super([mobileNumber]);

  @override
  String toString() => 'OtpPageLoaded { mobileNumber: $mobileNumber }';
}

class ClearFormAfterLogin extends LoginEvent {

  ClearFormAfterLogin();

  @override
  String toString() => 'ClearFormAfterLogin';
}

class ForgotPasswordButtonPressed extends LoginEvent {
  final String username;
  final String password;

  ForgotPasswordButtonPressed({
    @required this.username,
    @required this.password,
  }) : super([username, password]);

  @override
  String toString() =>
      'ForgotPasswordButtonPressed { username: $username, password: $password }';
}
