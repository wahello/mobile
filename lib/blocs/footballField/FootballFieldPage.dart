import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_system/blocs/footballField/FootballFieldBloc.dart';
import 'package:football_system/blocs/footballField/FootballFieldScreen.dart';
import 'package:football_system/blocs/footballField/FootballFieldState.dart';
import 'package:football_system/blocs/footballField/football_screen.dart';
import 'package:football_system/blocs/incontro/inserimento/index.dart';
import 'package:football_system/blocs/model/incontro_model.dart';
import 'package:football_system/blocs/model/player_model.dart';

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

class FootballFieldPage extends StatefulWidget {
  final InserimentoBloc inserimentoBloc;

  FootballFieldBloc footballFieldBloc;

  FootballFieldPage({this.inserimentoBloc}) {
    footballFieldBloc = FootballFieldBloc(
        dimension: [9, 11],
        availablePlayers: inserimentoBloc.incontro.players,
        module: inserimentoBloc.incontro.module);
  }
  @override
  FootballFieldPageState createState() {
    return FootballFieldPageState(
        inserimentoBloc: inserimentoBloc, footballFieldBloc: footballFieldBloc);
  }
}

class FootballFieldPageState extends State<FootballFieldPage> {
  FootballFieldBloc footballFieldBloc;
  InserimentoBloc inserimentoBloc;
  List<int> dimension;

  FootballFieldPageState({this.inserimentoBloc, this.footballFieldBloc});

  List getPlayersSelected(InserimentoBloc inserimentoBloc) {
    return inserimentoBloc.selectedPlayers;
  }

//TODO: rendere più dinamico
  List<int> getDimensionFromCategory(Incontro incontro) {
    List<int> category = List<int>();

    switch (incontro.category.name) {
      case 'Serie A':
        category.add(9);
        category.add(11);
        break;
      default:
        category.add(9);
        category.add(11);
        break;
    }

    return category;
  }

  @override
  Widget build(BuildContext context) {
    return FootballFieldScreen(
      lato: 30,
      inserimentoIncontroBloc: inserimentoBloc,
      footballFieldBloc: footballFieldBloc,
    );
  }
}
