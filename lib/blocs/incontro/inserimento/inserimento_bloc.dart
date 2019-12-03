import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:football_system/blocs/model/category_model.dart';
import 'package:football_system/blocs/model/championship_model.dart';
import 'package:football_system/blocs/model/coach_model.dart';
import 'package:football_system/blocs/model/gender_model.dart';
import 'package:football_system/blocs/model/incontro_model.dart';
import 'package:football_system/blocs/model/match_model.dart';
import 'package:football_system/blocs/model/player_model.dart';
import 'package:football_system/blocs/model/team_model.dart';
import 'package:football_system/blocs/model/tournament_model.dart';
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
  List selectedPlayers = [];
  String selectedCoach;
  Incontro incontro;

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
        List<Player> giocatori = selectedPlayers
            .map((player) => players
                .singleWhere((giocatore) => giocatore.id.toString() == player))
            .toList();
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
        yield InserisciIncontroState(incontro: incontro);
      } catch (error) {
        yield InserimentoFailure(error: error.toString());
      }
      yield InserimentoFinishState();
    }
  }
}
