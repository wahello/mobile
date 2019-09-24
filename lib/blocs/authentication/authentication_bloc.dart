import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../user/user_repository.dart';
import 'index.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({@required this.userRepository})
      : assert(userRepository != null);

  bool hasToken = false;
  bool registered = false;
  final UserRepository userRepository;

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
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
      if (hasToken) await userRepository.deleteKey('token');
      yield AuthenticationUnauthenticated();
    }

    if (event is OTP) {
      yield AuthenticationLoading();
      yield OTPRequired();
    }
  }
}
