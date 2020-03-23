import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_system/blocs/home/index.dart';
import 'package:football_system/blocs/incontro/inserimento/index.dart';
import 'package:football_system/blocs/splash/index.dart';
import 'package:football_system/blocs/stuff/calls_repository.dart';
import 'package:football_system/blocs/stuff/index.dart';
import 'package:football_system/generated/i18n.dart';
import 'package:shared/shared.dart';

import 'blocs/authentication/index.dart';
import 'blocs/login/index.dart';
import 'blocs/stuff/page.dart';
import 'blocs/ocr/index.dart';
import 'blocs/stuff/ocrWidget.dart';
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
  Widget appBarTitleText = new Text(I18n().appName);
  List<Widget> actions = [];
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
    authenticationBloc = AuthenticationBloc();
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
          //start to implement routing of app
          routes: {
            '/splashPage': (context) => SplashPage(),
            '/loginPage': (context) => LoginPage(
                  key: FormKey.loginKey,
                  callsRepository: callsRepository,
                  userRepository: userRepository,
                ),
            /*
                importante: il push delle pagine funziona solo con widget di tipo material(quindi devono essere
                figli di uno scaffold come per l'home page e l'incontro page)
                */
            '/homePage': (context) => CustomPage(
                  actions: actions,
                  appBarTitleText: appBarTitleText,
                  authenticationBloc: authenticationBloc,
                  child: HomePage(
                    authenticationBloc: authenticationBloc,
                    notifyAction: this.updateAppBarActions,
                    notifyParent: this.updateAppBarTitle,
                    key: FormKey.homeKey,
                  ),
                  key: FormKey.homeKey,
                ),
            '/incontroPage': (context) => CustomPage(
                  key: FormKey.matchPageKey,
                  actions: actions,
                  appBarTitleText: appBarTitleText,
                  authenticationBloc: authenticationBloc,
                  child: InserimentoPage(
                      key: FormKey.matchPageKey,
                      notifyAction: this.updateAppBarActions,
                      notifyParent: this.updateAppBarTitle),
                ),
            //Chiama direttamente la OcrPage perché al suo interno ha già appbar e scaffold
            OcrPage.routeName: (context) => OcrPage(
                key: FormKey.ocrPageKey,
                notifyAction: this.updateAppBarActions,
                notifyParent: this.updateAppBarTitle),
          },
          home: BlocListener<AuthenticationBloc, AuthenticationState>(
            child: Scaffold(
              key: FormKey.loadingKey,
              body: LoadingIndicator(),
            ),
            bloc: authenticationBloc,
            listener: (BuildContext context, AuthenticationState state) {
              if (state is AuthenticationUninitialized) {
                Navigator.pushNamed(context, '/splashPage');
              }
              if (state is InserimentoPageSelected) {
                Navigator.pushNamed(context, '/incontroPage');
              }
              if (state is AuthenticationUnauthenticated) {
                print(state);
                Navigator.pushNamed(context, '/loginPage');
              }
              if (state is Logout) {
                Navigator.popUntil(context, ModalRoute.withName('/loginPage'));
              }
              if (state is BackedToHomeFromButton) {
                Navigator.pushNamed(context, '/homePage');
              }
              if (state is AuthenticationAuthenticated ||
                  state is OTPRequired) {
                Navigator.pushNamed(context, '/homePage');
              }
              if (state is OCRPageState) {
                Navigator.pushNamed(context, '/ocr',
                    arguments: state.ocrPageArgument);
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
