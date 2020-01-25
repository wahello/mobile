import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:football_system/blocs/addForm/addFormSingleInstance.dart';
import 'package:football_system/blocs/addForm/index.dart';
import 'package:http/http.dart' as http;
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
import 'package:flutter/material.dart';

import './index.dart';

class InserimentoBloc extends Bloc<InserimentoEvent, InserimentoState> {
  final CallsRepository callsRepository = new CallsRepository();

  List<Category> categories;
  List<Championship> championships;
  List<Gender> genders;
  List<Partita> matches;
  List<Tournament> tournaments = [];
  List<Team> teams;
  List<Player> playersHome;
  List<Player> playersAway;
  List<Coach> coachesHome;
  List<Coach> coachesAway;
  String selectedCategories;
  String selectedChampionships;
  String selectedGender;
  String selectedMatches;
  String selectedTournament;
  String selectedTeamHome;
  String selectedTeamAway;
  String selectedModuleHome;
  String selectedModuleAway;
  List selectedPlayersFromCheckBoxListHome = [];
  List selectedPlayersFromCheckBoxListAway = [];
  List selectedPlayersHome = [];
  List selectedPlayersAway = [];
  String selectedCoachHome;
  String selectedCoachAway;
  Incontro incontroHome;
  Incontro incontroAway;
  List<Note> notes;
  List<Event> event;
  List<Module> modules;
  int activeTeam; //1 o 2
  FootballFieldBloc footballFieldBlocHome;
  FootballFieldBloc footballFieldBlocAway;

  String getTeamNameById(String id) {
    if (id != null && id != "") {
      return teams
          .singleWhere((team) => team.id.toString() == id.toString())
          .name;
    }
    return "";
  }

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
    if (event is GetTeamsEventHome || event is GetTeamsEventAway) {
      yield GetTeamsState();
      yield InserimentoLoadingState();
      try {
        final response = await callsRepository.getTeams(selectedCategories);
        if (response.statusCode == 200 && response.reasonPhrase == 'OK') {
          var list = jsonDecode(response.body) as List;
          List<Team> teamsList =
              list.map((team) => Team.fromJson(team)).toList();
          teams = teamsList;
        } else {
          yield InserimentoFailure(
              error: jsonDecode(response.reasonPhrase).toString());
        }
      } catch (error) {
        yield InserimentoFailure(error: error.toString());
      }
      yield InserimentoFinishState();
    }
    if (event is GetPlayersEventHome) {
      yield GetPlayersState();
      yield InserimentoLoadingState();
      try {
        final response = await callsRepository.getPlayers(selectedTeamHome);
        if (response.statusCode == 200 && response.reasonPhrase == 'OK') {
          var list = jsonDecode(response.body) as List;
          List<Player> playersList =
              list.map((player) => Player.fromJson(player)).toList();
          playersHome = playersList;
        } else {
          yield InserimentoFailure(
              error: jsonDecode(response.reasonPhrase).toString());
        }
      } catch (error) {
        yield InserimentoFailure(error: error.toString());
      }
      yield InserimentoFinishState();
    }
    if (event is GetPlayersEventAway) {
      yield GetPlayersState();
      yield InserimentoLoadingState();
      try {
        final response = await callsRepository.getPlayers(selectedTeamAway);
        if (response.statusCode == 200 && response.reasonPhrase == 'OK') {
          var list = jsonDecode(response.body) as List;
          List<Player> playersList =
              list.map((player) => Player.fromJson(player)).toList();
          playersAway = playersList;
        } else {
          yield InserimentoFailure(
              error: jsonDecode(response.reasonPhrase).toString());
        }
      } catch (error) {
        yield InserimentoFailure(error: error.toString());
      }
      yield InserimentoFinishState();
    }
    if (event is GetCoachesEventHome) {
      yield GetCoachesState();
      yield InserimentoLoadingState();
      try {
        final response = await callsRepository.getCoaches(selectedTeamHome);
        if (response.statusCode == 200 && response.reasonPhrase == 'OK') {
          var list = jsonDecode(response.body) as List;
          List<Coach> coachesList =
              list.map((coach) => Coach.fromJson(coach)).toList();
          coachesHome = coachesList;
        } else {
          yield InserimentoFailure(
              error: jsonDecode(response.reasonPhrase).toString());
        }
      } catch (error) {
        yield InserimentoFailure(error: error.toString());
      }
      yield InserimentoFinishState();
    }
    if (event is GetCoachesEventAway) {
      yield GetCoachesState();
      yield InserimentoLoadingState();
      try {
        final response = await callsRepository.getCoaches(selectedTeamAway);
        if (response.statusCode == 200 && response.reasonPhrase == 'OK') {
          var list = jsonDecode(response.body) as List;
          List<Coach> coachesList =
              list.map((coach) => Coach.fromJson(coach)).toList();
          coachesAway = coachesList;
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
        List<Player> giocatoriHome = selectedPlayersFromCheckBoxListHome
            .map((player) => playersHome
                .singleWhere((giocatore) => giocatore.id.toString() == player))
            .toList();
        List<Player> giocatoriAway = selectedPlayersFromCheckBoxListAway
            .map((player) => playersAway
                .singleWhere((giocatore) => giocatore.id.toString() == player))
            .toList();
        incontroHome = new Incontro(
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
              int.parse(selectedTeamHome),
              teams
                  .singleWhere((team) => team.id.toString() == selectedTeamHome)
                  .name),
          giocatoriHome,
          new Coach(
              int.parse(selectedCoachHome),
              coachesHome
                  .singleWhere(
                      (coach) => coach.id.toString() == selectedCoachHome)
                  .name),
        );
        incontroHome.module = modules.singleWhere(
            (module) => module.id.toString() == selectedModuleHome.toString());

        incontroAway = new Incontro(
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
              int.parse(selectedTeamAway),
              teams
                  .singleWhere((team) => team.id.toString() == selectedTeamAway)
                  .name),
          giocatoriAway,
          new Coach(
              int.parse(selectedCoachAway),
              coachesAway
                  .singleWhere(
                      (coach) => coach.id.toString() == selectedCoachAway)
                  .name),
        );
        incontroAway.module = modules.singleWhere(
            (module) => module.id.toString() == selectedModuleAway.toString());
      } catch (error) {
        yield InserimentoFailure(error: error.toString());
      }
    }
    if (event is InserisciModuloEventHome ||
        event is InserisciModuloEventAway) {
      var category = categories.singleWhere(
          (category) => category.id == int.parse(selectedCategories));

      //chiamo il be per farmi restituire i moduli per la categoria scelta
      var response =
          await callsRepository.getTactics(category.profileId.toString());

      var list = jsonDecode(response.body) as List;
      List<Module> modulesList =
          list.map((module) => Module.fromJson(module)).toList();
      modules = modulesList;

      print(modules);
    }
    if (event is SubmitFormEvent) {
      yield InserimentoLoadingState();
      try {
        http.Response _resp = await AddFormRepository().sendData(
            event.dataToSend, event.type, event.categoryId, event.teamId);
        if (_resp?.statusCode != 200) {
          yield InserimentoFormError();
          return;
        }
      } catch (error) {
        yield InserimentoFormError();
        return;
      }
      switch (event.type) {
        case TypeAddForm.TEAM:
          event.isHome ? add(GetTeamsEventHome()) : add(GetTeamsEventAway());
          break;
        case TypeAddForm.COACH:
          event.isHome
              ? add(GetCoachesEventHome())
              : add(GetCoachesEventAway());

          break;
        case TypeAddForm.PLAYER:
          event.isHome
              ? add(GetPlayersEventHome())
              : add(GetPlayersEventAway());

          break;
        default:
      }
      yield InserimentoFormSuccess();
    }
    if (event is SalvaIncontro) {
        //TODO eliminare il print e chiamare il provider
      print(incontroAway.toJson());
    }
  }
}
