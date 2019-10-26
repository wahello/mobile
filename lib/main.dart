import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_system/blocs/splash/splash_page.dart';
import 'package:football_system/blocs/stuff/calls_repository.dart';
import 'package:football_system/blocs/stuff/index.dart';

import 'blocs/authentication/index.dart';
import 'blocs/home/index.dart';
import 'blocs/login/index.dart';
import 'blocs/user/index.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print('$error, $stacktrace');
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(App(
      callsRepository: CallsRepository(), userRepository: UserRepository()));
}

class App extends StatefulWidget {
  final CallsRepository callsRepository;
  final UserRepository userRepository;

  App({Key key, @required this.callsRepository, @required this.userRepository})
      : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  AuthenticationBloc authenticationBloc;
  LoginBloc loginBloc;
  CallsRepository get callsRepository => widget.callsRepository;
  UserRepository get userRepository => widget.userRepository;

  @override
  void initState() {
    authenticationBloc = AuthenticationBloc(
      callsRepository: callsRepository,
    );
    authenticationBloc.add(AppStarted());
    loginBloc = LoginBloc(
      callsRepository: callsRepository,
      userRepository: userRepository,
      authenticationBloc: authenticationBloc,
    );
    super.initState();
  }

  @override
  void dispose() {
    authenticationBloc.close();
    loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      builder: (BuildContext context) => authenticationBloc,
      child: MaterialApp(
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (BuildContext context, AuthenticationState state) {
            if (state is AuthenticationUninitialized) {
              return SplashPage();
            }
            if (state is AuthenticationUnauthenticated) {
              return LoginPage(
                callsRepository: callsRepository,
                userRepository: userRepository,
              );
            }
            if (state is AuthenticationLoading) {
              return LoadingIndicator();
            }
            if (state is OTPRequired) {
              return OTPPage(
                loginBloc: loginBloc,
              );
            }
            if (state is AuthenticationAuthenticated) {
              return HomePage();
            }
          },
        ),
      ),
    );
  }
}
