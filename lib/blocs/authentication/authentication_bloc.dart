import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:football_system/blocs/stuff/calls_repository.dart';
import 'package:meta/meta.dart';

import 'index.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({@required this.callsRepository})
      : assert(callsRepository != null);

  bool hasToken = false;
  bool registered = false;
  final CallsRepository callsRepository;

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    yield AuthenticationUninitialized();
    await Future.delayed(Duration(seconds: 5));

    if (event is AppStarted) {
      yield AuthenticationLoading();
      yield AuthenticationUnauthenticated();
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      hasToken = await callsRepository.hasToken();
      if (hasToken) await callsRepository.deleteKey('token');
      yield AuthenticationUnauthenticated();
    }

    if (event is OTP) {
      yield AuthenticationLoading();
      yield OTPRequired();
    }
  }
}
