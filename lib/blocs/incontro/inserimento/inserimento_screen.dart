import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:football_system/blocs/home/index.dart';
import 'package:football_system/blocs/incontro/inserimento/index.dart';
import 'package:football_system/blocs/model/tournament_model.dart';
import 'package:football_system/blocs/stuff/calls_repository.dart';
import 'package:football_system/blocs/stuff/index.dart';
import 'package:football_system/generated/i18n.dart';
import 'package:shared/shared.dart';

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

  final GlobalKey<FormBuilderState> playerKey = GlobalKey<FormBuilderState>();
  final _controller = PageController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    inserimentoBloc.add(InserimentoStarted());
    super.initState();
  }

  Widget genderScreen(state) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: MainColors.SECONDARY,
        ),
        padding: const EdgeInsets.only(left: 80.0, right: 80.0),
        child: Column(children: <Widget>[
          Spacer(),
          FormBuilder(
            autovalidate: true,
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
                        // width: MediaQuery.of(context).size.width,
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
          ),
          Spacer()
        ]));
  }

  Widget championshipScreen(state) {
    return Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: MainColors.SECONDARY,
        ),
        padding: const EdgeInsets.only(left: 60.0, right: 60.0),
        child: Column(children: <Widget>[
          Spacer(),
          FormBuilder(
              autovalidate: true,
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
          Spacer(),
        ]));
  }

  Widget matchScreen(state) {
    return Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: MainColors.SECONDARY,
        ),
        padding: const EdgeInsets.only(left: 60.0, right: 60.0),
        child: Column(children: <Widget>[
          Spacer(),
          FormBuilder(
              autovalidate: true,
              child: Column(children: <Widget>[
                FormBuilderDropdown(
                  readOnly:
                      inserimentoBloc.selectedGender != null ? false : true,
                  onChanged: (value) =>
                      {inserimentoBloc.selectedMatches = value},
                  attribute: "match",
                  decoration: InputDecoration(labelText: I18n().matches),
                  initialValue: inserimentoBloc.matches != null
                      ? inserimentoBloc.selectedMatches
                      : null,
                  hint: Text(I18n().selectMatch),
                  validators: [
                    FormBuilderValidators.required(
                        errorText: I18n().obbligatorio)
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
                            inserimentoBloc.add(
                                GetTournamentsEvent(inputTextValue: value));
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
          Spacer(),
        ]));
  }

  Widget categoryScreen(state) {
    return Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: MainColors.SECONDARY,
        ),
        padding: const EdgeInsets.only(left: 60.0, right: 60.0),
        child: Column(children: <Widget>[
          Spacer(),
          FormBuilder(
              autovalidate: true,
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
                    FormBuilderValidators.required(
                        errorText: I18n().obbligatorio)
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
          Spacer(),
        ]));
  }

  Widget teamScreen(state) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: MainColors.SECONDARY,
      ),
      padding: const EdgeInsets.only(left: 60.0, right: 60.0),
      child: Column(
        children: <Widget>[
          Spacer(),
          FormBuilder(
              autovalidate: true,
              child: Column(children: <Widget>[
                FormBuilderDropdown(
                  onChanged: (value) => {inserimentoBloc.selectedTeam = value},
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
          Spacer(),
        ],
      ),
    );
  }

  Widget playersScreen(state) {
    return Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: MainColors.SECONDARY,
        ),
        padding: const EdgeInsets.only(left: 60.0, right: 60.0),
        child: Column(children: <Widget>[
          Spacer(),
          FormBuilder(
              key: playerKey,
              autovalidate: true,
              child: Column(children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      FormBuilderCheckboxList(
                        activeColor: MainColors.PRIMARY,
                        decoration: InputDecoration(labelText: I18n().players),
                        attribute: "players",
                        initialValue: inserimentoBloc.players != null
                            ? inserimentoBloc.selectedPlayers
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
                          inserimentoBloc.selectedPlayers = playerKey
                              .currentState.fields['players'].currentState.value
                        },
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
                                goToStep(7);
                              },
                              padding: const EdgeInsets.symmetric(
                                vertical: 20.0,
                                horizontal: 20.0,
                              ),
                              child: Text(
                                // I18n().avanti,
                                inserimentoBloc.selectedPlayers.toString(),
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
          Spacer(),
        ]));
  }

  Widget coachesScreen(state) {
    // goToStep(7);
  }

  Widget incontroScreen(homeBloc, state) {
    return inserimentoBloc.incontro != null
        ? Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: MainColors.SECONDARY,
            ),
            padding: const EdgeInsets.only(left: 60.0, right: 60.0),
            child: Column(children: <Widget>[
              Spacer(),
              Row(
                children: <Widget>[
                  Text(
                    I18n().incontroInserito,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: MainColors.PRIMARY,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  )
                ],
              ),
              SizedBox(height: 24),
              inserimentoBloc.incontro.gender != null
                  ? Row(
                      children: <Widget>[
                        Text(
                          I18n().gender,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: MainColors.PRIMARY,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          inserimentoBloc.incontro.gender.name,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: MainColors.TEXT,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    )
                  : new Container(),
              inserimentoBloc.incontro.gender != null
                  ? SizedBox(height: 24)
                  : new Container(),
              inserimentoBloc.incontro.championship != null
                  ? Row(
                      children: <Widget>[
                        Text(
                          I18n().championship,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: MainColors.PRIMARY,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          inserimentoBloc.incontro.championship.name,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: MainColors.TEXT,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    )
                  : new Container(),
              inserimentoBloc.incontro.championship != null
                  ? SizedBox(height: 24)
                  : new Container(),
              inserimentoBloc.incontro.match != null
                  ? Row(
                      children: <Widget>[
                        Text(
                          I18n().match,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: MainColors.PRIMARY,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          inserimentoBloc.incontro.match.name,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: MainColors.TEXT,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    )
                  : new Container(),
              inserimentoBloc.incontro.match != null
                  ? SizedBox(height: 24)
                  : new Container(),
              inserimentoBloc.incontro.tournament != null
                  ? Row(
                      children: <Widget>[
                        Text(
                          I18n().trophy,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: MainColors.PRIMARY,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          inserimentoBloc.incontro.tournament.name,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: MainColors.TEXT,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    )
                  : new Container(),
              inserimentoBloc.incontro.tournament != null
                  ? SizedBox(height: 24)
                  : new Container(),
              inserimentoBloc.incontro.category != null
                  ? Row(
                      children: <Widget>[
                        Text(
                          I18n().category,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: MainColors.PRIMARY,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          inserimentoBloc.incontro.category.name,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: MainColors.TEXT,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    )
                  : new Container(),
              inserimentoBloc.incontro.players != null
                  ? Row(
                      children: <Widget>[
                        Text(
                          I18n().category,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: MainColors.PRIMARY,
                              fontWeight: FontWeight.bold),
                        ),
                        getTextWidgets(inserimentoBloc.incontro.players),
                      ],
                    )
                  : new Container(),
              SizedBox(height: 50),
              Container(
                child: Center(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    color: MainColors.PRIMARY,
                    onPressed: () => {homeBloc.add(HomeStarted())},
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
                              I18n().homePage,
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
              ),
              Spacer(),
            ]),
          )
        : new Container();
  }

  Widget getTextWidgets(dynamic elements) {
    return new Row(
        children: elements
            .map(
              (item) => new Text(
                item.name,
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
      if (inserimentoBloc.matches == null || inserimentoBloc.matches.isEmpty) {
        inserimentoBloc.add(GetMatchesEvent());
      }
    }
    if (step == 3) {
      if (inserimentoBloc.categories == null ||
          inserimentoBloc.categories.isEmpty) {
        inserimentoBloc.add(GetCategoriesEvent());
      }
    }
    if (step == 4) {
      if (inserimentoBloc.teams == null || inserimentoBloc.teams.isEmpty) {
        inserimentoBloc.add(GetTeamsEvent());
      }
    }
    if (step == 5) {
      if (inserimentoBloc.players == null || inserimentoBloc.players.isEmpty) {
        inserimentoBloc.add(GetPlayersEvent());
      }
    }
    if (step == 6) {
      if (inserimentoBloc.coaches == null || inserimentoBloc.coaches.isEmpty) {
        inserimentoBloc.add(GetCoachesEvent());
      }
    }
    if (step == 7) {
      if (inserimentoBloc.incontro == null) {
        inserimentoBloc.add(IncontroInseritoEvent());
      }
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

          return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: PageView(
                controller: _controller,
                physics: new AlwaysScrollableScrollPhysics(),
                children: <Widget>[
                  genderScreen(state),
                  championshipScreen(state),
                  matchScreen(state),
                  categoryScreen(state),
                  teamScreen(state),
                  playersScreen(state),
                  coachesScreen(state),
                  incontroScreen(homeBloc, state)
                ],
                scrollDirection: Axis.horizontal,
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return _body(homeBloc: BlocProvider.of<HomeBloc>(context));
  }
}
