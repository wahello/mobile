import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:football_system/blocs/home/home_event.dart';
import 'package:football_system/blocs/model/category_model.dart';
import 'package:football_system/blocs/model/championship_model.dart';
import 'package:football_system/blocs/model/coach_model.dart';
import 'package:football_system/blocs/model/gender_model.dart';
import 'package:football_system/blocs/model/incontro_model.dart';
import 'package:football_system/blocs/model/match_model.dart';
import 'package:football_system/blocs/model/module_model.dart';
import 'package:football_system/blocs/model/player_model.dart';
import 'package:football_system/blocs/model/team_model.dart';
import 'package:football_system/blocs/model/tournament_model.dart';
import 'package:football_system/blocs/stuff/event.dart';
import 'package:football_system/blocs/stuff/index.dart';

import './index.dart';

class InserimentoBloc extends Bloc<InserimentoEvent, InserimentoState> {
  final CallsRepository callsRepository = new CallsRepository();

  List<Category> categories;
  List<Championship> championships;
  List<Gender> genders;
  List<Partita> matches;
  List<Tournament> tournaments = [];
  List<Team> teams;
  List<Player> players;
  List<Coach> coaches;
  String selectedCategories;
  String selectedChampionships;
  String selectedGender;
  String selectedMatches;
  String selectedTournament;
  String selectedTeam;
  String selectedModule;
  List selectedPlayersFromCheckBoxList = [];
  List selectedPlayers = [];
  String selectedCoach;
  Incontro incontro;
  List<Note> notes;
  List<Event> event;
  List<Module> modules;

  @override
  InserimentoState get initialState => InitialInserimentoState();

  @override
  Stream<InserimentoState> mapEventToState(
    InserimentoEvent event,
  ) async* {
    if (event is InserimentoStarted) {
      yield InserimentoUninitialized();
      yield InserimentoLoadingState();
      try {
        final response = await callsRepository.getGenders();
        if (response.statusCode == 200 && response.reasonPhrase == 'OK') {
          var list = jsonDecode(response.body) as List;
          List<Gender> genderList =
              list.map((gender) => Gender.fromJson(gender)).toList();
          genders = genderList;
        } else {
          yield InserimentoFailure(
              error: jsonDecode(response.reasonPhrase).toString());
        }
      } catch (error) {
        yield InserimentoFailure(error: error.toString());
      }
      try {
        final response = await callsRepository.getChampionships();
        if (response.statusCode == 200 && response.reasonPhrase == 'OK') {
          var list = jsonDecode(response.body) as List;
          List<Championship> championshipsList = list
              .map((championship) => Championship.fromJson(championship))
              .toList();
          championships = championshipsList;
        } else {
          yield InserimentoFailure(
              error: jsonDecode(response.reasonPhrase).toString());
        }
      } catch (error) {
        yield InserimentoFailure(error: error.toString());
      }
      yield InserimentoInitialized();
    }
    if (event is GetGendersEvent) {
      yield GetGendersState();
      yield InserimentoLoadingState();
      try {
        final response = await callsRepository.getGenders();
        if (response.statusCode == 200 && response.reasonPhrase == 'OK') {
          var list = jsonDecode(response.body) as List;
          List<Gender> genderList =
              list.map((gender) => Gender.fromJson(gender)).toList();
          genders = genderList;
        } else {
          yield InserimentoFailure(
              error: jsonDecode(response.reasonPhrase).toString());
        }
      } catch (error) {
        yield InserimentoFailure(error: error.toString());
      }
      yield InserimentoFinishState();
    }
    if (event is GetChampionshipsEvent) {
      yield GetChampionshipsState();
      yield InserimentoLoadingState();
      try {
        final response = await callsRepository.getChampionships();
        if (response.statusCode == 200 && response.reasonPhrase == 'OK') {
          var list = jsonDecode(response.body) as List;
          List<Championship> championshipsList = list
              .map((championship) => Championship.fromJson(championship))
              .toList();
          championships = championshipsList;
        } else {
          yield InserimentoFailure(
              error: jsonDecode(response.reasonPhrase).toString());
        }
      } catch (error) {
        yield InserimentoFailure(error: error.toString());
      }
      yield InserimentoFinishState();
    }
    if (event is GetMatchesEvent) {
      yield GetMatchesState(selectedChampionships: selectedChampionships);
      yield InserimentoLoadingState();
      try {
        final response =
            await callsRepository.getMatches(selectedChampionships);
        if (response.statusCode == 200 && response.reasonPhrase == 'OK') {
          var list = jsonDecode(response.body) as List;
          List<Partita> matchesList =
              list.map((match) => Partita.fromJson(match)).toList();
          matches = matchesList;
        } else {
          yield InserimentoFailure(
              error: jsonDecode(response.reasonPhrase).toString());
        }
      } catch (error) {
        yield InserimentoFailure(error: error.toString());
      }
      yield InserimentoFinishState();
    }
    if (event is GetCategoriesEvent) {
      yield GetCategoriesState(
          selectedGender: selectedGender,
          selectedChampionships: selectedChampionships,
          selectedMatches: selectedMatches);
      yield InserimentoLoadingState();
      try {
        final response = await callsRepository.getCategories(
            selectedGender, selectedChampionships, selectedMatches);
        if (response.statusCode == 200 && response.reasonPhrase == 'OK') {
          var list = jsonDecode(response.body) as List;
          List<Category> categoriesList =
              list.map((match) => Category.fromJson(match)).toList();
          categories = categoriesList;
        } else {
          yield InserimentoFailure(
              error: jsonDecode(response.reasonPhrase).toString());
        }
      } catch (error) {
        yield InserimentoFailure(error: error.toString());
      }
      yield InserimentoFinishState();
    }
    if (event is GetTournamentsEvent) {
      yield GetTournamentsState();
      yield InserimentoLoadingState();
      try {
        final response =
            await callsRepository.getTournaments(event.inputTextValue);
        if (response.statusCode == 200 && response.reasonPhrase == 'OK') {
          var list = jsonDecode(response.body) as List;
          List<Tournament> tournamentsList = list
              .map((tournament) => Tournament.fromJson(tournament))
              .toList();
          tournaments = tournamentsList;
        } else {
          yield InserimentoFailure(
              error: jsonDecode(response.reasonPhrase).toString());
        }
      } catch (error) {
        yield InserimentoFailure(error: error.toString());
      }
      yield InserimentoFinishState();
    }
    if (event is GetTeamsEvent) {
      yield GetTeamsState();
      yield InserimentoLoadingState();
      try {
        final response = await callsRepository.getTeams(selectedCategories);
        if (response.statusCode == 200 && response.reasonPhrase == 'OK') {
          var list = jsonDecode(response.body) as List;
          List<Team> teamsList =
              list.map((team) => Team.fromJson(team)).toList();
          teams = teamsList;
          List<Team> playersFromShared =
              await CallsRepository().readKey('teams');
          teams.addAll(playersFromShared);
        } else {
          yield InserimentoFailure(
              error: jsonDecode(response.reasonPhrase).toString());
        }
      } catch (error) {
        yield InserimentoFailure(error: error.toString());
      }
      yield InserimentoFinishState();
    }
    if (event is GetPlayersEvent) {
      yield GetPlayersState();
      yield InserimentoLoadingState();
      try {
        final response = await callsRepository.getPlayers(selectedTeam);
        if (response.statusCode == 200 && response.reasonPhrase == 'OK') {
          var list = jsonDecode(response.body) as List;
          List<Player> playersList =
              list.map((player) => Player.fromJson(player)).toList();
          players = playersList;
          List playersFromShared = await CallsRepository().readKey('players');
        } else {
          yield InserimentoFailure(
              error: jsonDecode(response.reasonPhrase).toString());
        }
      } catch (error) {
        yield InserimentoFailure(error: error.toString());
      }
      yield InserimentoFinishState();
    }
    if (event is GetCoachesEvent) {
      yield GetCoachesState();
      yield InserimentoLoadingState();
      try {
        final response = await callsRepository.getCoaches(selectedTeam);
        if (response.statusCode == 200 && response.reasonPhrase == 'OK') {
          var list = jsonDecode(response.body) as List;
          List<Coach> coachesList =
              list.map((coach) => Coach.fromJson(coach)).toList();
          coaches = coachesList;
        } else {
          yield InserimentoFailure(
              error: jsonDecode(response.reasonPhrase).toString());
        }
      } catch (error) {
        yield InserimentoFailure(error: error.toString());
      }
      yield InserimentoFinishState();
    }
    if (event is InserisciIncontroEvent) {
      // yield InserisciIncontroState();
      try {
        List<Player> giocatori = selectedPlayersFromCheckBoxList
            .map((player) => players
                .singleWhere((giocatore) => giocatore.id.toString() == player))
            .toList();
        selectedPlayers = giocatori;
        incontro = new Incontro(
          new Gender(
              int.parse(selectedGender),
              genders
                  .singleWhere(
                      (gender) => gender.id.toString() == selectedGender)
                  .name),
          new Category(
              int.parse(selectedCategories),
              categories
                  .singleWhere((category) =>
                      category.id.toString() == selectedCategories)
                  .name),
          new Championship(
              int.parse(selectedChampionships),
              championships
                  .singleWhere((championship) =>
                      championship.id.toString() == selectedChampionships)
                  .name),
          new Partita(
              int.parse(selectedMatches),
              matches
                  .singleWhere(
                      (match) => match.id.toString() == selectedMatches)
                  .name),
          selectedTournament != null
              ? new Tournament(
                  int.parse(selectedTournament),
                  tournaments
                      .singleWhere((tournament) =>
                          tournament.id.toString() == selectedTournament)
                      .name)
              : null,
          new Team(
              int.parse(selectedTeam),
              teams
                  .singleWhere((team) => team.id.toString() == selectedTeam)
                  .name),
          giocatori,
          new Coach(
              int.parse(selectedCoach),
              coaches
                  .singleWhere((coach) => coach.id.toString() == selectedCoach)
                  .name),
        );
        incontro.module = modules.singleWhere(
            (module) => module.id.toString() == selectedModule.toString());
      } catch (error) {
        yield InserimentoFailure(error: error.toString());
      }
    }
    if (event is InserisciModuloEvent) {
      //chiamo il be per farmi restituire i moduli per la categoria scelta
      this.modules = await modulesByCategoryId(selectedChampionships);
      // await callsRepository.getTactics(incontro.championship.id.toString());

      print(modules);
    }
  }

  Future<List<Module>> modulesByCategoryId(String categoryId) async {
    return await Future.delayed(
      Duration(seconds: 2),
      () => [
        new Module(
            createdAt: '2019-12-08',
            id: 1,
            name: '4-4-2',
            positions: [
              '1,2',
              '6,3',
              '4,1',
              '10,5',
              '1,6',
              '6,5',
              '4,7',
              '10,3',
              '8,7',
              '8,1',
              '12,4'
            ],
            profileId: 1,
            updatedAt: '2019-12-08'),
        new Module(
            createdAt: '2019-12-08',
            id: 2,
            name: '4-3-3',
            positions: [
              '1,2',
              '6,3',
              '4,1',
              '10,5',
              '1,6',
              '6,5',
              '6,5',
              '6,3',
              '8,7',
              '8,1',
              '12,4'
            ],
            profileId: 1,
            updatedAt: '2019-12-08')
      ],
    );
  }
}
