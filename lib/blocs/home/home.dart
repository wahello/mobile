import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_system/blocs/authentication/index.dart';
import 'package:football_system/blocs/home/index.dart';
import 'package:football_system/blocs/incontro/inserimento/index.dart';
import 'package:football_system/blocs/splash/index.dart';
import 'package:football_system/blocs/stuff/calls_repository.dart';
import 'package:football_system/blocs/user/index.dart';

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
  runApp(Home(
      callsRepository: CallsRepository(), userRepository: UserRepository()));
}

class Home extends StatefulWidget {
  final CallsRepository callsRepository;
  final UserRepository userRepository;
  final Function(Widget widget) notifyParent;
  final Function(Widget widget) notifyAction;
  final Function(Size size, InserimentoBloc) activeSaveButton;
  final Function(Size size) deactiveSaveButton;

  Home(
      {Key key,
      this.deactiveSaveButton,
      this.activeSaveButton,
      this.notifyAction,
      this.notifyParent,
      @required this.callsRepository,
      @required this.userRepository})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeBloc homeBloc;
  AuthenticationBloc authenticationBloc;
  InserimentoBloc inserimentoBloc;
  CallsRepository get callsRepository => widget.callsRepository;
  UserRepository get userRepository => widget.userRepository;

  @override
  void initState() {
    homeBloc = HomeBloc(
      callsRepository: callsRepository,
    );
    authenticationBloc = AuthenticationBloc(
      callsRepository: callsRepository,
    );
    inserimentoBloc = InserimentoBloc();
    homeBloc.add(HomeStarted());
    super.initState();
  }

  @override
  void updateAppBarTitle(Widget _widget) {
    widget.notifyParent(_widget);
  }

  @override
  void updateAppBarActions(Widget _widget) {
    widget.notifyAction(_widget);
  }

  @override
  void dispose() {
    homeBloc.close();
    authenticationBloc.close();
    inserimentoBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.deactiveSaveButton(MediaQuery.of(context).size);
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            builder: (context) => authenticationBloc,
          ),
          BlocProvider<HomeBloc>(
            builder: (context) => homeBloc,
          ),
          BlocProvider<InserimentoBloc>(
            builder: (context) => inserimentoBloc,
          ),
        ],
        child: BlocProvider<HomeBloc>(
            builder: (BuildContext context) => homeBloc,
            child: Scaffold(
              body: BlocBuilder<HomeBloc, HomeState>(
                builder: (BuildContext context, HomeState state) {
                  if (state is HomeInitialized) {
                    return HomePage();
                  }
                  if (state is InserimentoIncontroState) {
                    return InserimentoPage(
                      notifyParent: updateAppBarTitle,
                      notifyAction: updateAppBarActions,
                      activeSaveButton: widget.activeSaveButton,
                    );
                  }
                  return SplashPage();
                },
              ),
            )));
  }
}
