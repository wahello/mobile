import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:football_system/blocs/stuff/calls_repository.dart';
import 'package:meta/meta.dart';

import 'index.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  static final AuthenticationBloc _authenticationBloc =
      AuthenticationBloc._internal();
  factory AuthenticationBloc() {
    return _authenticationBloc;
  }
  AuthenticationBloc._internal();

  bool hasToken = false;
  bool registered = false;


  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield AuthenticationUninitialized();
      await Future.delayed(Duration(seconds: 5));
      yield AuthenticationLoading();
      yield AuthenticationUnauthenticated();
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      yield AuthenticationAuthenticated();
    }
    if (event is GoHome) {
      yield BackedToHomeFromButton();
    }

    if(event is OCRPage){
      yield OCRPageState();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      hasToken = await CallsRepository().hasToken();
      if (hasToken) await CallsRepository().deleteKey('token');
      yield Logout();
    }

    if (event is OTP) {
      yield AuthenticationLoading();
      yield OTPRequired();
    }

    if (event is GoToInserimentoPage) {
      yield InserimentoPageSelected();
    }
  }
}
