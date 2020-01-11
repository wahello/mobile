import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:football_system/blocs/addForm/addFormSingleInstance.dart';
import 'package:football_system/blocs/addForm/index.dart';
import 'package:football_system/blocs/footballField/FootballFieldBloc.dart';
import 'package:football_system/blocs/footballField/FootballFieldPage.dart';
import 'package:football_system/blocs/footballField/FootballFieldScreen.dart';
import 'package:football_system/blocs/footballField/football_screen.dart';
import 'package:football_system/blocs/home/index.dart';
import 'package:football_system/blocs/incontro/inserimento/index.dart';
import 'package:football_system/blocs/model/player_model.dart';
import 'package:football_system/blocs/model/tournament_model.dart';
import 'package:football_system/blocs/stuff/calls_repository.dart';
import 'package:football_system/blocs/stuff/index.dart';
import 'package:football_system/generated/i18n.dart';
import 'package:shared/shared.dart';
import '../../stuff/index.dart';

class InserimentoScreen extends StatefulWidget {
  const InserimentoScreen({
    Key key,
  }) : super(key: key);

  @override
  InserimentoScreenState createState() => InserimentoScreenState();
}

class InserimentoScreenState extends State<InserimentoScreen>
    with TickerProviderStateMixin {
  InserimentoBloc inserimentoBloc = new InserimentoBloc();
  CallsRepository callsRepository = new CallsRepository();
  ScrollController _scrollController = new ScrollController();
  ScrollController _scrollControllerForPlayers = new ScrollController();

  // Variabile di classe per gestire l'ovveride del back button
  int step;

  var _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    inserimentoBloc.add(InserimentoStarted());
  }

  Widget genderScreen(state) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: MainColors.SECONDARY,
        ),
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(children: <Widget>[
          SizedBox(
              height: (MediaQuery.of(context).size.height -
                      (MediaQuery.of(context).size.height * 0.5)) /
                  2),
          FormBuilder(
            autovalidate: false,
            child: Column(
              children: <Widget>[
                FormBuilderDropdown(
                  onChanged: (value) =>
                      {inserimentoBloc.selectedGender = value},
                  attribute: "gender",
                  decoration: InputDecoration(labelText: I18n().genders),
                  initialValue: inserimentoBloc.genders != null
                      ? inserimentoBloc.selectedGender
                      : null,
                  hint: Text(I18n().selectGender),
                  validators: [
                    FormBuilderValidators.required(
                        errorText: I18n().obbligatorio)
                  ],
                  items: inserimentoBloc.genders != null
                      ? inserimentoBloc.genders
                          .map((gender) => DropdownMenuItem(
                              value: gender.id.toString(),
                              child: Text(gender.name.toString())))
                          .toList()
                      : [],
                ),
                state is InserimentoLoadingState
                    ? Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        child: LoadingIndicator(),
                      )
                    : Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        alignment: Alignment.center,
                        child: FlatButton(
                          disabledColor: MainColors.DISABLED,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          color: MainColors.PRIMARY,
                          onPressed: state is! InserimentoLoadingState &&
                                  inserimentoBloc.selectedGender != null
                              ? () => goToStep(1)
                              : null,
                          child: new Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 20.0,
                            ),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Expanded(
                                  child: Text(
                                    I18n().avanti,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: MainColors.TEXT_NEGATIVE,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  Widget championshipScreen(state) {
    return Center(
        child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: MainColors.SECONDARY,
      ),
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        children: <Widget>[
          SizedBox(
              height: (MediaQuery.of(context).size.height -
                      (MediaQuery.of(context).size.height * 0.5)) /
                  2),
          FormBuilder(
              autovalidate: false,
              child: Column(children: <Widget>[
                FormBuilderDropdown(
                  readOnly:
                      inserimentoBloc.selectedGender != null ? false : true,
                  onChanged: (value) =>
                      {inserimentoBloc.selectedChampionships = value},
                  attribute: "championship",
                  decoration: InputDecoration(labelText: I18n().championships),
                  initialValue: inserimentoBloc.championships != null
                      ? inserimentoBloc.selectedChampionships
                      : null,
                  hint: Text(I18n().selectChampionship),
                  validators: [
                    FormBuilderValidators.required(
                        errorText: I18n().obbligatorio)
                  ],
                  items: inserimentoBloc.championships != null
                      ? inserimentoBloc.championships
                          .map((championship) => DropdownMenuItem(
                              value: championship.id.toString(),
                              child: Text(championship.name.toString())))
                          .toList()
                      : [],
                ),
                state is InserimentoLoadingState
                    ? Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        child: LoadingIndicator(),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            margin: const EdgeInsets.only(top: 20.0),
                            alignment: Alignment.centerLeft,
                            child: FlatButton(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                              color: MainColors.PRIMARY,
                              onPressed: () => goToStep(0),
                              padding: const EdgeInsets.symmetric(
                                vertical: 20.0,
                                horizontal: 20.0,
                              ),
                              child: Text(
                                I18n().indietro,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: MainColors.TEXT_NEGATIVE,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            margin: const EdgeInsets.only(top: 20.0),
                            alignment: Alignment.centerRight,
                            child: FlatButton(
                              disabledColor: MainColors.DISABLED,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                              color: MainColors.PRIMARY,
                              onPressed:
                                  inserimentoBloc.selectedChampionships != null
                                      ? () => goToStep(2)
                                      : null,
                              padding: const EdgeInsets.symmetric(
                                vertical: 20.0,
                                horizontal: 20.0,
                              ),
                              child: Text(
                                I18n().avanti,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: MainColors.TEXT_NEGATIVE,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      )
              ])),
        ],
      ),
    ));
  }

  Widget matchScreen(state) {
    return Center(
        child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: MainColors.SECONDARY,
      ),
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(children: <Widget>[
        SizedBox(
            height: (MediaQuery.of(context).size.height -
                    (MediaQuery.of(context).size.height * 0.5)) /
                2),
        FormBuilder(
            autovalidate: false,
            child: Column(children: <Widget>[
              FormBuilderDropdown(
                readOnly: inserimentoBloc.selectedGender != null ? false : true,
                onChanged: (value) => {inserimentoBloc.selectedMatches = value},
                attribute: "match",
                decoration: InputDecoration(labelText: I18n().matches),
                initialValue: inserimentoBloc.matches != null
                    ? inserimentoBloc.selectedMatches
                    : null,
                hint: Text(I18n().selectMatch),
                validators: [
                  FormBuilderValidators.required(errorText: I18n().obbligatorio)
                ],
                items: inserimentoBloc.matches != null
                    ? inserimentoBloc.matches
                        .map((match) => DropdownMenuItem(
                            value: match.id.toString(),
                            child: Text(match.name.toString())))
                        .toList()
                    : [],
              ),
              inserimentoBloc.selectedMatches == "2"
                  ? FormBuilderTypeAhead(
                      decoration: InputDecoration(
                        labelText: I18n().trophies,
                      ),
                      attribute: 'trophy',
                      onChanged: (value) => {
                        inserimentoBloc
                            .add(GetTournamentsEvent(inputTextValue: value))
                      },
                      onSuggestionSelected: (value) =>
                          {inserimentoBloc.selectedTournament = value},
                      itemBuilder: (context, Tournament suggestion) {
                        return ListTile(
                          title: Text(suggestion.name),
                        );
                      },
                      selectionToTextTransformer: (Tournament suggestion) =>
                          suggestion.name,
                      suggestionsCallback: (value) {
                        if (value.length != 0 &&
                            inserimentoBloc.tournaments.length > 0) {
                          var lowercaseQuery = value.toLowerCase();
                          return inserimentoBloc.tournaments
                              .where((tournament) {
                            return tournament.name
                                .toLowerCase()
                                .contains(lowercaseQuery);
                          }).toList(growable: false)
                                ..sort((a, b) => a.name
                                    .toLowerCase()
                                    .indexOf(lowercaseQuery)
                                    .compareTo(b.name
                                        .toLowerCase()
                                        .indexOf(lowercaseQuery)));
                        } else {
                          inserimentoBloc
                              .add(GetTournamentsEvent(inputTextValue: value));
                          return inserimentoBloc.tournaments;
                        }
                      },
                    )
                  : Row(),
              state is InserimentoLoadingState
                  ? Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      child: LoadingIndicator(),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          margin: const EdgeInsets.only(top: 20.0),
                          alignment: Alignment.centerLeft,
                          child: FlatButton(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            color: MainColors.PRIMARY,
                            onPressed: () => goToStep(1),
                            padding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 20.0,
                            ),
                            child: Text(
                              I18n().indietro,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: MainColors.TEXT_NEGATIVE,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          margin: const EdgeInsets.only(top: 20.0),
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            disabledColor: MainColors.DISABLED,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            color: MainColors.PRIMARY,
                            onPressed:
                                inserimentoBloc.selectedChampionships != null
                                    ? () => goToStep(3)
                                    : null,
                            padding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 20.0,
                            ),
                            child: Text(
                              I18n().avanti,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: MainColors.TEXT_NEGATIVE,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    )
            ])),
      ]),
    ));
  }

  Widget categoryScreen(state) {
    return Center(
        child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: MainColors.SECONDARY,
      ),
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(children: <Widget>[
        SizedBox(
            height: (MediaQuery.of(context).size.height -
                    (MediaQuery.of(context).size.height * 0.5)) /
                2),
        FormBuilder(
            autovalidate: false,
            child: Column(children: <Widget>[
              FormBuilderDropdown(
                readOnly:
                    inserimentoBloc.selectedMatches != null ? false : true,
                onChanged: (value) =>
                    {inserimentoBloc.selectedCategories = value},
                attribute: "cateogry",
                decoration: InputDecoration(labelText: I18n().categories),
                initialValue: inserimentoBloc.categories != null
                    ? inserimentoBloc.selectedCategories
                    : null,
                hint: Text(I18n().selectCategory),
                validators: [
                  FormBuilderValidators.required(errorText: I18n().obbligatorio)
                ],
                items: inserimentoBloc.categories != null
                    ? inserimentoBloc.categories
                        .map((cateogry) => DropdownMenuItem(
                            value: cateogry.id.toString(),
                            child: Text(cateogry.name.toString())))
                        .toList()
                    : [],
              ),
              state is InserimentoLoadingState
                  ? Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      child: LoadingIndicator(),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          margin: const EdgeInsets.only(top: 20.0),
                          alignment: Alignment.centerLeft,
                          child: FlatButton(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            color: MainColors.PRIMARY,
                            onPressed: () => goToStep(2),
                            padding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 20.0,
                            ),
                            child: Text(
                              I18n().indietro,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: MainColors.TEXT_NEGATIVE,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          margin: const EdgeInsets.only(top: 20.0),
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            disabledColor: MainColors.DISABLED,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            color: MainColors.PRIMARY,
                            onPressed:
                                inserimentoBloc.selectedCategories != null
                                    ? () => goToStep(4)
                                    : null,
                            padding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 20.0,
                            ),
                            child: Text(
                              I18n().avanti,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: MainColors.TEXT_NEGATIVE,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    )
            ])),
      ]),
    ));
  }

  Widget teamScreen(state) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
            child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: MainColors.SECONDARY,
          ),
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(children: <Widget>[
            SizedBox(
                height: (MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).size.height * 0.5)) /
                    2),
            FormBuilder(
                autovalidate: false,
                child: Column(children: <Widget>[
                  FormBuilderDropdown(
                    onChanged: (value) =>
                        {inserimentoBloc.selectedTeam = value},
                    attribute: "team",
                    decoration: InputDecoration(labelText: I18n().teams),
                    initialValue: inserimentoBloc.teams != null
                        ? inserimentoBloc.selectedTeam
                        : null,
                    hint: Text(I18n().selectTeam),
                    validators: [
                      FormBuilderValidators.required(
                          errorText: I18n().obbligatorio)
                    ],
                    items: inserimentoBloc.teams != null
                        ? inserimentoBloc.teams
                            .map((team) => DropdownMenuItem(
                                value: team.id.toString(),
                                child: Text(team.name.toString())))
                            .toList()
                        : [],
                  ),
                  AddFormScreen(
                    type: TypeAddForm.TEAM,
                    bloc: inserimentoBloc,
                    state: state,
                    categoryId: inserimentoBloc.selectedCategories,
                    teamId: inserimentoBloc.selectedTeam,
                  ),
                  state is InserimentoLoadingState
                      ? Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          child: LoadingIndicator(),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              margin: const EdgeInsets.only(top: 20.0),
                              alignment: Alignment.centerLeft,
                              child: FlatButton(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                                color: MainColors.PRIMARY,
                                onPressed: () => goToStep(3),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20.0,
                                  horizontal: 20.0,
                                ),
                                child: Text(
                                  I18n().indietro,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: MainColors.TEXT_NEGATIVE,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              margin: const EdgeInsets.only(top: 20.0),
                              alignment: Alignment.centerRight,
                              child: FlatButton(
                                disabledColor: MainColors.DISABLED,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                                color: MainColors.PRIMARY,
                                onPressed: inserimentoBloc.selectedTeam != null
                                    ? () => goToStep(5)
                                    : null,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20.0,
                                  horizontal: 20.0,
                                ),
                                child: Text(
                                  I18n().avanti,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: MainColors.TEXT_NEGATIVE,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        )
                ])),
          ]),
        )));
  }

  Widget playersScreen(state) {
    return SingleChildScrollView(
      controller: _scrollControllerForPlayers,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: MainColors.SECONDARY,
        ),
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height / 8),
            FormBuilder(
              key: FormKey.playersKey,
              autovalidate: true,
              child: Column(
                children: <Widget>[
                  Container(
                    child: ListView(
                      controller: _scrollControllerForPlayers,
                      shrinkWrap: true,
                      children: <Widget>[
                        FormBuilderCheckboxList(
                          activeColor: MainColors.PRIMARY,
                          decoration:
                              InputDecoration(labelText: I18n().players),
                          attribute: "players",
                          initialValue: inserimentoBloc.players != null
                              ? inserimentoBloc.selectedPlayersFromCheckBoxList
                              : null,
                          options: inserimentoBloc.players != null
                              ? inserimentoBloc.players
                                  .map((player) => FormBuilderFieldOption(
                                      value: player.id.toString(),
                                      child: Text(player.name.toString())))
                                  .toList()
                              : [],
                          validators: [
                            FormBuilderValidators.required(
                                errorText: I18n().obbligatorio)
                          ],
                          onChanged: (value) => {
                            inserimentoBloc.selectedPlayersFromCheckBoxList =
                                value
                          },
                        ),
                      ],
                    ),
                  ),
                  AddFormScreen(
                    type: TypeAddForm.PLAYER,
                    bloc: inserimentoBloc,
                    state: state,
                    categoryId: inserimentoBloc.selectedCategories,
                    teamId: inserimentoBloc.selectedTeam,
                  ),
                  state is InserimentoLoadingState
                      ? Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          child: LoadingIndicator(),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              margin: const EdgeInsets.only(top: 20.0),
                              alignment: Alignment.centerLeft,
                              child: FlatButton(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                                color: MainColors.PRIMARY,
                                onPressed: () => goToStep(4),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20.0,
                                  horizontal: 20.0,
                                ),
                                child: Text(
                                  I18n().indietro,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: MainColors.TEXT_NEGATIVE,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              margin: const EdgeInsets.only(top: 20.0),
                              alignment: Alignment.centerRight,
                              child: FlatButton(
                                disabledColor: MainColors.DISABLED,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                                color: MainColors.PRIMARY,
                                onPressed: () {
                                  goToStep(6);
                                },
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20.0,
                                  horizontal: 20.0,
                                ),
                                child: Text(
                                  I18n().avanti,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: MainColors.TEXT_NEGATIVE,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget coachesScreen(state) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: MainColors.SECONDARY,
            ),
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 150),
                FormBuilder(
                  key: FormKey.coachesKey,
                  autovalidate: false,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: ListView(
                          shrinkWrap: true,
                          children: <Widget>[
                            FormBuilderRadio(
                              activeColor: MainColors.PRIMARY,
                              decoration:
                                  InputDecoration(labelText: I18n().coaches),
                              attribute: "coaches",
                              initialValue: inserimentoBloc.coaches != null
                                  ? inserimentoBloc.selectedCoach
                                  : null,
                              options: inserimentoBloc.coaches != null
                                  ? inserimentoBloc.coaches
                                      .map((coach) => FormBuilderFieldOption(
                                          value: coach.id.toString(),
                                          child: Text(coach.name.toString())))
                                      .toList()
                                  : [],
                              validators: [
                                FormBuilderValidators.required(
                                    errorText: I18n().obbligatorio)
                              ],
                              onChanged: (value) =>
                                  {inserimentoBloc.selectedCoach = value},
                            ),
                            AddFormScreen(
                              type: TypeAddForm.COACH,
                              bloc: inserimentoBloc,
                              state: state,
                              categoryId: inserimentoBloc.selectedCategories,
                              teamId: inserimentoBloc.selectedTeam,
                            ),
                          ],
                        ),
                      ),
                      state is InserimentoLoadingState
                          ? Container(
                              margin: const EdgeInsets.only(top: 20.0),
                              child: LoadingIndicator(),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  margin: const EdgeInsets.only(top: 20.0),
                                  alignment: Alignment.centerLeft,
                                  child: FlatButton(
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0),
                                    ),
                                    color: MainColors.PRIMARY,
                                    onPressed: () => goToStep(5),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20.0,
                                      horizontal: 20.0,
                                    ),
                                    child: Text(
                                      I18n().indietro,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: MainColors.TEXT_NEGATIVE,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  margin: const EdgeInsets.only(top: 20.0),
                                  alignment: Alignment.centerRight,
                                  child: FlatButton(
                                    disabledColor: MainColors.DISABLED,
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0),
                                    ),
                                    color: MainColors.PRIMARY,
                                    onPressed: () {
                                      goToStep(7);
                                    },
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20.0,
                                      horizontal: 20.0,
                                    ),
                                    child: Text(
                                      I18n().avanti,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: MainColors.TEXT_NEGATIVE,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget moduleScreen(InserimentoState state) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Center(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: MainColors.SECONDARY,
          ),
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 150),
              FormBuilder(
                key: FormKey.modulesKey,
                autovalidate: false,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: ListView(
                        controller: _scrollController,
                        shrinkWrap: true,
                        children: <Widget>[
                          FormBuilderRadio(
                            activeColor: MainColors.PRIMARY,
                            decoration:
                                InputDecoration(labelText: I18n().modules),
                            attribute: "modules",
                            initialValue: inserimentoBloc.modules != null
                                ? inserimentoBloc.selectedModule
                                : null,
                            options: inserimentoBloc.modules != null
                                ? inserimentoBloc.modules
                                    .map((module) => FormBuilderFieldOption(
                                        value: module.id.toString(),
                                        child: Text(module.name.toString())))
                                    .toList()
                                : [],
                            validators: [
                              FormBuilderValidators.required(
                                  errorText: I18n().obbligatorio)
                            ],
                            onChanged: (value) =>
                                {inserimentoBloc.selectedModule = value},
                          ),
                        ],
                      ),
                    ),
                    inserimentoBloc.modules == null
                        ? Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            child: LoadingIndicator(),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                margin: const EdgeInsets.only(top: 20.0),
                                alignment: Alignment.centerLeft,
                                child: FlatButton(
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0),
                                  ),
                                  color: MainColors.PRIMARY,
                                  onPressed: () => goToStep(6),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20.0,
                                    horizontal: 20.0,
                                  ),
                                  child: Text(
                                    I18n().indietro,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: MainColors.TEXT_NEGATIVE,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                margin: const EdgeInsets.only(top: 20.0),
                                alignment: Alignment.centerRight,
                                child: FlatButton(
                                  disabledColor: MainColors.DISABLED,
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0),
                                  ),
                                  color: inserimentoBloc.selectedModule == null
                                      ? MainColors.DISABLED
                                      : MainColors.PRIMARY,
                                  onPressed: () {
                                    goToStep(8);
                                  },
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20.0,
                                    horizontal: 20.0,
                                  ),
                                  child: Text(
                                    I18n().avanti,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: MainColors.TEXT_NEGATIVE,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget incontroScreen() {
    return inserimentoBloc.incontro != null &&
            inserimentoBloc.incontro.module != null
        ? FootballFieldScreen(
            inserimentoIncontroBloc: inserimentoBloc,
            footballFieldBloc: FootballFieldBloc(
                dimension: [9, 11],
                availablePlayers: inserimentoBloc.incontro.players,
                module: inserimentoBloc.incontro.module),
            lato: 30,
          )
        : LoadingIndicator();
  }

  Widget getPlayerTextWidgets(List<Player> elements) {
    return new Row(
        children: elements
            .map(
              (item) => new Text(
                item.name + ', ',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: MainColors.TEXT, fontWeight: FontWeight.normal),
              ),
            )
            .toList());
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  void goToStep(int step) {
    this.step = step;
    if (step == 0) {
      if (inserimentoBloc.genders == null || inserimentoBloc.genders.isEmpty) {
        inserimentoBloc.add(GetGendersEvent());
      }
    }
    if (step == 1) {
      if (inserimentoBloc.championships == null ||
          inserimentoBloc.championships.isEmpty) {
        inserimentoBloc.add(GetChampionshipsEvent());
      }
    }
    if (step == 2) {
      inserimentoBloc.add(GetMatchesEvent());
    }
    if (step == 3) {
      inserimentoBloc.add(GetCategoriesEvent());
    }
    if (step == 4) {
      inserimentoBloc.add(GetTeamsEvent());
    }
    if (step == 5) {
      inserimentoBloc.add(GetPlayersEvent());
    }
    if (step == 6) {
      inserimentoBloc.add(GetCoachesEvent());
    }
    if (step == 7) {
      inserimentoBloc.add(InserisciModuloEvent());
    }
    if (step == 8) {
      if (inserimentoBloc.selectedModule == null)
        step = 7;
      else
        inserimentoBloc.add(InserisciIncontroEvent());
    }
    _controller.animateToPage(
      step,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  Widget _body({HomeBloc homeBloc, BuildContext context}) {
    return BlocBuilder<InserimentoBloc, InserimentoState>(
        bloc: inserimentoBloc,
        builder: (
          BuildContext context,
          InserimentoState state,
        ) {
          if (state is InserimentoFailure) {
            _onWidgetDidBuild(() {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.error}'),
                  backgroundColor: MainColors.PRIMARY,
                ),
              );
            });
          }
          return WillPopScope(
              onWillPop: () {
                goToStep(step - 1);
                return Future.delayed(Duration(seconds: 1));
              },
              child: Container(
                  child: PageView(
                      controller: _controller,
                      physics: const NeverScrollableScrollPhysics(),
                      children: <Widget>[
                    genderScreen(state),
                    championshipScreen(state),
                    matchScreen(state),
                    categoryScreen(state),
                    teamScreen(state),
                    playersScreen(state),
                    coachesScreen(state),
                    moduleScreen(state),
                    incontroScreen(),
                  ])));
        });
  }

  @override
  Widget build(BuildContext context) {
    return _body(homeBloc: BlocProvider.of<HomeBloc>(context));
  }
}
