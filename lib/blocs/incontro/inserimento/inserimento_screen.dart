import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:football_system/blocs/incontro/inserimento/index.dart';
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

  Widget firstStepScreen(state) {
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

  Widget secondStepScreen(state) {
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

  Widget thirdStepScreen(state) {
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

  Widget fourthStepScreen(state) {
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

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  void goToStep(int step) {
    if (step == 0) {
      if (inserimentoBloc.genders == null) {
        inserimentoBloc.add(GetGendersEvent());
      }
    }
    if (step == 1) {
      if (inserimentoBloc.championships == null) {
        inserimentoBloc.add(GetChampionshipsEvent());
      }
    }
    if (step == 2) {
      if (inserimentoBloc.matches == null) {
        inserimentoBloc.add(GetMatchesEvent());
      }
    }
    if (step == 3) {
      if (inserimentoBloc.categories == null) {
        inserimentoBloc.add(GetCategoriesEvent());
      }
    }
    _controller.animateToPage(
      step,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  firstStepScreen(state),
                  secondStepScreen(state),
                  thirdStepScreen(state),
                  fourthStepScreen(state)
                ],
                scrollDirection: Axis.horizontal,
              ));
        });
  }
}
