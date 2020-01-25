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
import 'blocs/incontro/inserimento/index.dart';

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
  Widget appBarTitleText = new Text(I18n().appName);
  List<Widget> actions = [];
  List<Widget> persistentFloatingButton = null;
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

  void updateAppBarTitle(Widget widget) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        appBarTitleText = widget;
      });
    });
  }

  void activeSaveButton(Size size, InserimentoBloc inserimentoBloc) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        persistentFloatingButton = [
          Container(
            margin: EdgeInsets.only(right: size.width / 4.72),
            child: FloatingActionButton(
              backgroundColor: MainColors.PRIMARY,
              child: Icon(Icons.home),
              heroTag: "home",
              onPressed: () => {authenticationBloc.add(GoHome())},
            ),
          ),
          Container(
            child: FloatingActionButton(
              backgroundColor: MainColors.PRIMARY,
              child: Icon(Icons.save),
              heroTag: "save",
              onPressed: () => {inserimentoBloc.add(SalvaIncontro())},
            ),
          ),
        ];
      });
    });
  }

  void deactiveSaveButton(Size size) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        persistentFloatingButton = [
          Container(
            margin: EdgeInsets.only(right: size.width / 4.72),
            child: FloatingActionButton(
              backgroundColor: MainColors.PRIMARY,
              child: Icon(Icons.home),
              heroTag: "home",
              onPressed: () => {authenticationBloc.add(GoHome())},
            ),
          ),
          Container(
            child: FloatingActionButton(
              backgroundColor: MainColors.DISABLED,
              child: Icon(Icons.save),
              heroTag: "save",
              onPressed: () => {},
            ),
          ),
        ];
      });
    });
  }

  void updateAppBarActions(Widget widget) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        actions = widget != null ? [widget] : [];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      key: FormKey.multiBlocProviderKey,
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
          key: FormKey.materialAppKey,
          theme: ThemeData(
            hintColor: MainColors.PRIMARY,
            cursorColor: MainColors.PRIMARY,
            indicatorColor: MainColors.PRIMARY,
          ),
          home: BlocListener<AuthenticationBloc, AuthenticationState>(
            child: Scaffold(
              key: FormKey.loadingKey,
              body: LoadingIndicator(),
            ),
            bloc: authenticationBloc,
            listener: (BuildContext context, AuthenticationState state) {
              if (state is AuthenticationUninitialized) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return SplashPage(
                      key: FormKey.fliploaderkey,
                    );
                  }),
                );
              }
              if (state is AuthenticationUnauthenticated) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return WillPopScope(
                      key: FormKey.authenticationUnauthenticated,
                      onWillPop: () async => false,
                      child: LoginPage(
                        key: FormKey.loginKey,
                        callsRepository: callsRepository,
                        userRepository: userRepository,
                      ),
                    );
                  }),
                );
              }
              if (state is AuthenticationAuthenticated ||
                  state is OTPRequired) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return WillPopScope(
                      key: FormKey.authenticationAuthenticated,
                      onWillPop: () async => false,
                      child: Scaffold(
                          key: FormKey.homeKey,
                          persistentFooterButtons: (persistentFloatingButton ??
                              [
                                Container(
                                  margin: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width /
                                          4.72),
                                  child: FloatingActionButton(
                                    backgroundColor: MainColors.PRIMARY,
                                    child: Icon(Icons.home),
                                    heroTag: "home",
                                    onPressed: () =>
                                        {authenticationBloc.add(GoHome())},
                                  ),
                                ),
                                Container(
                                  child: FloatingActionButton(
                                    backgroundColor: Colors.grey,
                                    child: Icon(Icons.save),
                                    heroTag: "save",
                                    onPressed: () => {},
                                  ),
                                ),
                              ]),
                          appBar: AppBar(
                            leading: FlatButton(
                              key: FormKey.logoutKey,
                              child: Icon(Icons.exit_to_app),
                              onPressed: () =>
                                  {authenticationBloc.add(LoggedOut())},
                            ),
                            title: appBarTitleText,
                            actions: actions,
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
                                      notifyAction: updateAppBarActions,
                                      callsRepository: callsRepository,
                                      userRepository: userRepository,
                                      activeSaveButton: activeSaveButton,
                                      deactiveSaveButton:
                                          deactiveSaveButton)))),
                    );
                  }),
                );
              }
            },
          )),
    );
  }
}
/*
BlocBuilder<AuthenticationBloc, AuthenticationState>(
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
                  persistentFooterButtons: <Widget>[
                    FloatingActionButton(
                      backgroundColor: MainColors.PRIMARY,
                      child: Icon(Icons.home),
                      heroTag: "home",
                      onPressed: () => {authenticationBloc.add(LoggedIn())},
                    ),
                    Divider(
                      endIndent: MediaQuery.of(context).size.width / 5,
                    ),
                    FloatingActionButton(
                      heroTag: "exit",
                      backgroundColor: MainColors.PRIMARY,
                      child: Icon(Icons.exit_to_app),
                      onPressed: () => {},
                    )
                  ],
                  appBar: AppBar(
                    title: appBarTitleText,
                    actions: actions,
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
                            notifyAction: updateAppBarActions,
                            callsRepository: callsRepository,
                            userRepository: userRepository,
                          ))));
            }
            return SplashPage();
          },
        ),
 */
