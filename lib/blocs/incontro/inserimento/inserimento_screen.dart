import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:football_system/blocs/addForm/addFormSingleInstance.dart';
import 'package:football_system/blocs/addForm/index.dart';
import 'package:football_system/blocs/footballField/FootballFieldBloc.dart';
import 'package:football_system/blocs/footballField/FootballFieldScreen.dart';
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
  final Function(Widget) notifyParent;
  final Function(Widget) notifyAction;

  const InserimentoScreen({
    this.notifyAction,
    this.notifyParent,
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
  PageController pageController = PageController();

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

  Widget teamScreenHome(state) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
            child: Container(
          height: MediaQuery.of(context).size.height,
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
                      6),
              Text(
                I18n().squadraDiCasa,
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                  height: (MediaQuery.of(context).size.height -
                          (MediaQuery.of(context).size.height * 0.5)) /
                      6),
              FormBuilder(
                  autovalidate: true,
                  child: Column(children: <Widget>[
                    FormBuilderDropdown(
                      onChanged: (value) => {_changeTeam(value, true)},
                      attribute: "team",
                      decoration: InputDecoration(labelText: I18n().teams),
                      initialValue: inserimentoBloc.teams != null
                          ? inserimentoBloc.selectedTeamHome
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
                      teamId: inserimentoBloc.selectedTeamHome,
                      isHome: true,
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
                                alignment: Alignment.centerLeft,
                                child: FlatButton(
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0),
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
                                alignment: Alignment.centerRight,
                                child: FlatButton(
                                  disabledColor: MainColors.DISABLED,
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0),
                                  ),
                                  color: MainColors.PRIMARY,
                                  onPressed:
                                      inserimentoBloc.selectedTeamHome != null
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
            ],
          ),
        )));
  }

  Widget teamScreenAway(state) {
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
                    6),
            Text(
              I18n().squadraOspite,
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
                height: (MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).size.height * 0.5)) /
                    6),
            FormBuilder(
                autovalidate: false,
                child: Column(children: <Widget>[
                  FormBuilderDropdown(
                    onChanged: (value) => {_changeTeam(value, false)},
                    attribute: "team",
                    decoration: InputDecoration(labelText: I18n().teams),
                    initialValue: inserimentoBloc.teams != null
                        ? inserimentoBloc.selectedTeamAway
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
                    teamId: inserimentoBloc.selectedTeamAway,
                    isHome: false,
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
                                onPressed: () => goToStep(7),
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
                                    inserimentoBloc.selectedTeamAway != null
                                        ? () => goToStep(9)
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

  void _changeTeam(String value, bool isHome) {
    if (!isHome) {
      if (inserimentoBloc.selectedTeamAway != value) {
        inserimentoBloc.selectedPlayersFromCheckBoxListAway?.clear();
      }
      inserimentoBloc.selectedTeamAway = value;
    } else {
      if (inserimentoBloc.selectedTeamHome != value) {
        inserimentoBloc.selectedPlayersFromCheckBoxListHome?.clear();
      }
      inserimentoBloc.selectedTeamHome = value;
    }
  }

  Widget playersScreenHome(state) {
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
            SizedBox(
                height: (MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).size.height * 0.5)) /
                    6),
            Text(
              I18n().squadraDiCasa,
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
                height: (MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).size.height * 0.5)) /
                    6),
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
                          initialValue: inserimentoBloc.playersHome != null
                              ? inserimentoBloc
                                  .selectedPlayersFromCheckBoxListHome
                              : null,
                          options: inserimentoBloc.playersHome != null
                              ? inserimentoBloc.playersHome
                                  .map((player) => FormBuilderFieldOption(
                                      value: player.id.toString(),
                                      child: Text(player.name.toString())))
                                  .toList()
                              : [],
                          validators: [
                            FormBuilderValidators.required(
                                errorText: I18n().obbligatorio),
                            // FormBuilderValidators.minLength(11,
                            //     errorText: I18n().minimoNumeroGiocatori(
                            //         '11')) //TODO PARAMETRIZZARE
                          ],
                          onChanged: (value) => {
                            inserimentoBloc
                                .selectedPlayersFromCheckBoxListHome = value
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
                      teamId: inserimentoBloc.selectedTeamHome,
                      isHome: true),
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
                                onPressed: (inserimentoBloc
                                                .selectedPlayersFromCheckBoxListHome
                                                ?.length ??
                                            0) >=
                                        1
                                    ? () => goToStep(6)
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
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget playersScreenAway(state) {
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
            SizedBox(
                height: (MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).size.height * 0.5)) /
                    6),
            Text(
              I18n().squadraOspite,
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
                height: (MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).size.height * 0.5)) /
                    6),
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
                          initialValue: inserimentoBloc.playersAway != null
                              ? inserimentoBloc
                                  .selectedPlayersFromCheckBoxListAway
                              : null,
                          options: inserimentoBloc.playersAway != null
                              ? inserimentoBloc.playersAway
                                  .map((player) => FormBuilderFieldOption(
                                      value: player.id.toString(),
                                      child: Text(player.name.toString())))
                                  .toList()
                              : [],
                          validators: [
                            FormBuilderValidators.required(
                                errorText: I18n().obbligatorio),
                            // FormBuilderValidators.minLength(11,
                            //     errorText: I18n().minimoNumeroGiocatori(
                            //         '11')) //TODO PARAMETRIZZARE
                          ],
                          onChanged: (value) => {
                            inserimentoBloc
                                .selectedPlayersFromCheckBoxListAway = value
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
                    teamId: inserimentoBloc.selectedTeamAway,
                    isHome: false,
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
                                onPressed: () => goToStep(8),
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
                                onPressed: (inserimentoBloc
                                                .selectedPlayersFromCheckBoxListAway
                                                ?.length ??
                                            0) >=
                                        1
                                    ? () => goToStep(10)
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
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget coachesScreenHome(state) {
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
                SizedBox(
                    height: (MediaQuery.of(context).size.height -
                            (MediaQuery.of(context).size.height * 0.5)) /
                        6),
                Text(
                  I18n().squadraDiCasa,
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                    height: (MediaQuery.of(context).size.height -
                            (MediaQuery.of(context).size.height * 0.5)) /
                        6),
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
                              initialValue: inserimentoBloc.coachesHome != null
                                  ? inserimentoBloc.selectedCoachHome
                                  : null,
                              options: inserimentoBloc.coachesHome != null
                                  ? inserimentoBloc.coachesHome
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
                                  {inserimentoBloc.selectedCoachHome = value},
                            ),
                            AddFormScreen(
                              type: TypeAddForm.COACH,
                              bloc: inserimentoBloc,
                              state: state,
                              categoryId: inserimentoBloc.selectedCategories,
                              teamId: inserimentoBloc.selectedTeamHome,
                              isHome: true,
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

  Widget coachesScreenAway(state) {
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
                SizedBox(
                    height: (MediaQuery.of(context).size.height -
                            (MediaQuery.of(context).size.height * 0.5)) /
                        6),
                Text(
                  I18n().squadraOspite,
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                    height: (MediaQuery.of(context).size.height -
                            (MediaQuery.of(context).size.height * 0.5)) /
                        6),
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
                              initialValue: inserimentoBloc.coachesAway != null
                                  ? inserimentoBloc.selectedCoachAway
                                  : null,
                              options: inserimentoBloc.coachesAway != null
                                  ? inserimentoBloc.coachesAway
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
                                  {inserimentoBloc.selectedCoachAway = value},
                            ),
                            AddFormScreen(
                              type: TypeAddForm.COACH,
                              bloc: inserimentoBloc,
                              state: state,
                              categoryId: inserimentoBloc.selectedCategories,
                              teamId: inserimentoBloc.selectedTeamAway,
                              isHome: false,
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
                                    onPressed: () => goToStep(9),
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
                                      goToStep(11);
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

  Widget moduleScreenHome(InserimentoState state) {
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
              SizedBox(
                  height: (MediaQuery.of(context).size.height -
                          (MediaQuery.of(context).size.height * 0.5)) /
                      6),
              Text(
                I18n().squadraDiCasa,
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                  height: (MediaQuery.of(context).size.height -
                          (MediaQuery.of(context).size.height * 0.5)) /
                      6),
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
                                ? inserimentoBloc.selectedModuleHome
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
                                {inserimentoBloc.selectedModuleHome = value},
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
                                  color:
                                      inserimentoBloc.selectedModuleHome == null
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

  Widget moduleScreenAway(InserimentoState state) {
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
              SizedBox(
                  height: (MediaQuery.of(context).size.height -
                          (MediaQuery.of(context).size.height * 0.5)) /
                      6),
              Text(
                I18n().squadraOspite,
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                  height: (MediaQuery.of(context).size.height -
                          (MediaQuery.of(context).size.height * 0.5)) /
                      6),
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
                                ? inserimentoBloc.selectedModuleAway
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
                                {inserimentoBloc.selectedModuleAway = value},
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
                                  onPressed: () => goToStep(10),
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
                                  color:
                                      inserimentoBloc.selectedModuleAway == null
                                          ? MainColors.DISABLED
                                          : MainColors.PRIMARY,
                                  onPressed: () {
                                    goToStep(12);
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

  Widget jerseyPage(InserimentoState state) {
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
              SizedBox(
                  height: (MediaQuery.of(context).size.height -
                          (MediaQuery.of(context).size.height * 0.5)) /
                      6),
              Text(
                I18n().squadraDiCasa,
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                  height: (MediaQuery.of(context).size.height -
                          (MediaQuery.of(context).size.height * 0.5)) /
                      6),
              FormBuilder(
                key: FormKey.jerseyKey,
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
                            decoration: InputDecoration(
                                labelText: I18n().divisaSquadraDiCasa),
                            attribute: "jerseys",
                            initialValue: inserimentoBloc.jerseyName != null
                                ? inserimentoBloc.jerseyNameHome
                                : null,
                            options: inserimentoBloc.jerseyName != null
                                ? inserimentoBloc.jerseyName
                                    .map((jersey) => FormBuilderFieldOption(
                                        value: jersey,
                                        child: Container(
                                          child: Text(''),
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(jersey))),
                                        )))
                                    .toList()
                                : [],
                            validators: [
                              FormBuilderValidators.required(
                                  errorText: I18n().obbligatorio)
                            ],
                            onChanged: (value) =>
                                {inserimentoBloc.jerseyNameHome = value},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: (MediaQuery.of(context).size.height -
                                (MediaQuery.of(context).size.height * 0.5)) /
                            6),
                    Text(
                      I18n().squadraOspite,
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                        height: (MediaQuery.of(context).size.height -
                                (MediaQuery.of(context).size.height * 0.5)) /
                            6),
                    Container(
                      child: ListView(
                        controller: _scrollController,
                        shrinkWrap: true,
                        children: <Widget>[
                          FormBuilderRadio(
                            activeColor: MainColors.PRIMARY,
                            decoration:
                                InputDecoration(labelText: I18n().divisaSquadraOspite),
                            attribute: "jerseys",
                            initialValue: inserimentoBloc.jerseyName != null
                                ? inserimentoBloc.jerseyNameAway
                                : null,
                            options: inserimentoBloc.jerseyName != null
                                ? inserimentoBloc.jerseyName
                                    .map((jersey) => FormBuilderFieldOption(
                                        value: jersey,
                                        child: Container(
                                          child: Text(''),
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(jersey))),
                                        )))
                                    .toList()
                                : [],
                            validators: [
                              FormBuilderValidators.required(
                                  errorText: I18n().obbligatorio)
                            ],
                            onChanged: (value) =>
                                {inserimentoBloc.jerseyNameAway = value},
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
                                  onPressed: () => goToStep(11),
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
                                  color:
                                      (inserimentoBloc.jerseyNameHome == null ||
                                              inserimentoBloc.jerseyNameAway ==
                                                  null)
                                          ? MainColors.DISABLED
                                          : MainColors.PRIMARY,
                                  onPressed: () {
                                    goToStep(13);
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

  Widget incontroScreen(
      Function(Widget) notifyParent, Function(Widget) notifyAction) {
    return ((inserimentoBloc.incontroHome != null &&
                inserimentoBloc.incontroHome.module != null) &&
            inserimentoBloc.incontroAway != null &&
            inserimentoBloc.incontroAway.module != null)
        ? PageView(
            controller: pageController,
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              FootballFieldScreen(
                isHome: true,
                notifyParent: notifyParent,
                notifyAction: notifyAction,
                inserimentoIncontroBloc: inserimentoBloc,
                footballFieldBloc: (inserimentoBloc.footballFieldBlocHome ??
                    (inserimentoBloc.footballFieldBlocHome = FootballFieldBloc(
                        dimension: [9, 11],
                        availablePlayers: inserimentoBloc.incontroHome.players,
                        module: inserimentoBloc.incontroHome.module))),
                lato: 30,
              ),
              FootballFieldScreen(
                isHome: false,
                notifyParent: notifyParent,
                notifyAction: notifyAction,
                inserimentoIncontroBloc: inserimentoBloc,
                footballFieldBloc: (inserimentoBloc.footballFieldBlocAway ??
                    (inserimentoBloc.footballFieldBlocAway = FootballFieldBloc(
                        dimension: [9, 11],
                        availablePlayers: inserimentoBloc.incontroAway.players,
                        module: inserimentoBloc.incontroAway.module))),
                lato: 30,
              )
            ],
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
      widget.notifyAction(null);
      inserimentoBloc.add(GetMatchesEvent());
    }
    if (step == 3) {
      widget.notifyAction(null);
      inserimentoBloc.add(GetCategoriesEvent());
    }
    if (step == 4) {
      widget.notifyAction(null);
      inserimentoBloc.add(GetTeamsEventHome());
    }
    if (step == 5) {
      widget.notifyAction(null);
      inserimentoBloc.add(GetPlayersEventHome());
    }
    if (step == 6) {
      inserimentoBloc.add(GetCoachesEventHome());
    }
    if (step == 7) {
      inserimentoBloc.add(InserisciModuloEventHome());
    }
    if (step == 8) {
      inserimentoBloc.add(GetTeamsEventAway());
    }
    if (step == 9) {
      inserimentoBloc.add(GetPlayersEventAway());
    }
    if (step == 10) {
      inserimentoBloc.add(GetCoachesEventAway());
    }
    if (step == 11) {
      inserimentoBloc.add((InserisciModuloEventAway()));
    }
    if (step == 12) {
      inserimentoBloc.add(ChooseJerseyEvent());
    }
    if (step == 13) {
      if (inserimentoBloc.selectedModuleAway == null)
        step = 12;
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
                    teamScreenHome(state),
                    playersScreenHome(state),
                    coachesScreenHome(state),
                    moduleScreenHome(state),
                    teamScreenAway(state),
                    playersScreenAway(state),
                    coachesScreenAway(state),
                    moduleScreenAway(state),
                    jerseyPage(state),
                    incontroScreen(widget.notifyParent, widget.notifyAction),
                  ])));
        });
  }

  @override
  Widget build(BuildContext context) {
    return _body(homeBloc: BlocProvider.of<HomeBloc>(context));
  }
}
