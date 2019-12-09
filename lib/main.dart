import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_system/blocs/home/index.dart';
import 'package:football_system/blocs/splash/index.dart';
import 'package:football_system/blocs/stuff/calls_repository.dart';
import 'package:football_system/blocs/stuff/index.dart';
import 'package:football_system/generated/i18n.dart';
import 'package:shared/shared.dart';

import 'blocs/authentication/index.dart';
import 'blocs/login/index.dart';
import 'blocs/user/index.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print('$error, $stacktrace');
  }

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
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(App(
      callsRepository: CallsRepository(), userRepository: UserRepository()));
}

class App extends StatefulWidget {
  App({Key key, @required this.callsRepository, @required this.userRepository})
      : super(key: key);

  final CallsRepository callsRepository;
  final UserRepository userRepository;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Text appBarTitleText = new Text(I18n().appName);
  AuthenticationBloc authenticationBloc;
  HomeBloc homeBloc;
  LoginBloc loginBloc;

  @override
  void dispose() {
    authenticationBloc.close();
    loginBloc.close();
    homeBloc.close();
    super.dispose();
  }

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
    homeBloc = HomeBloc(callsRepository: callsRepository);
    super.initState();
  }

  CallsRepository get callsRepository => widget.callsRepository;

  UserRepository get userRepository => widget.userRepository;

  void updateAppBarTitle(String title) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        appBarTitleText = Text(title);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          builder: (context) => authenticationBloc,
        ),
        BlocProvider<LoginBloc>(
          builder: (context) => loginBloc,
        ),
        BlocProvider<HomeBloc>(
          builder: (context) => homeBloc,
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          hintColor: MainColors.PRIMARY,
          cursorColor: MainColors.PRIMARY,
          indicatorColor: MainColors.PRIMARY,
        ),
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
            if (state is AuthenticationAuthenticated || state is OTPRequired) {
              return Scaffold(
                  appBar: AppBar(
                    title: appBarTitleText,
                    backgroundColor: MainColors.PRIMARY,
                  ),
                  body: Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: MainColors.SECONDARY,
                      ),
                      child: Container(
                          padding: EdgeInsets.all(3.0),
                          child: Home(
                            notifyParent: updateAppBarTitle,
                            callsRepository: callsRepository,
                            userRepository: userRepository,
                          ))));
            }
            return SplashPage();
          },
        ),
      ),
    );
  }
}
