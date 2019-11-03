import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:football_system/blocs/incontro/inserimento/index.dart';
import 'package:football_system/blocs/stuff/calls_model.dart';
import 'package:football_system/blocs/stuff/calls_repository.dart';
import 'package:football_system/generated/i18n.dart';
import 'package:shared/shared.dart';

class InserimentoScreen extends StatefulWidget {
  const InserimentoScreen({
    Key key,
    @required InserimentoBloc inserimentoBloc,
  })  : _inserimentoBloc = inserimentoBloc,
        super(key: key);

  final InserimentoBloc _inserimentoBloc;

  @override
  InserimentoScreenState createState() {
    return InserimentoScreenState(_inserimentoBloc);
  }
}

class InserimentoScreenState extends State<InserimentoScreen>
    with TickerProviderStateMixin {
  InserimentoScreenState(this._inserimentoBloc);

  CallsRepository callsRepository = new CallsRepository();
  List<Category> categories;
  List<Championship> championships;
  List<Gender> genders;
  List<Match> matches;
  String selectedCategories;
  String selectedChampionships;
  String selectedGender;
  String selectedMatches;

  final _controller = PageController();
  final InserimentoBloc _inserimentoBloc;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    if (genders == null) {
      _onWidgetDidBuild(getGenders);
    }
    if (championships == null) {
      _onWidgetDidBuild(getChampionships);
    }
    super.initState();
  }

  void getGenders() async {
    genders = await callsRepository.getGenders();
    _inserimentoBloc.add(InserimentoFinishEvent());
  }

  void getChampionships() async {
    championships = await callsRepository.getChampionships();
  }

  void getMatches() async {
    matches = await callsRepository.getMatches(selectedChampionships);
  }

  void getCategories() async {
    categories = await callsRepository.getCategories(
        selectedGender, selectedChampionships, selectedMatches);
  }

  void searchCategory(value) async {
    _inserimentoBloc.add(InserimentoLoadingEvent());
    categories = await callsRepository.getCategories(
        selectedGender, selectedChampionships, selectedMatches);
  }

  Widget firstStepScreen(state) {
    if (genders == null) {
      _onWidgetDidBuild(getGenders);
    }
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
                  onChanged: (value) => {selectedGender = value},
                  attribute: "gender",
                  decoration: InputDecoration(labelText: I18n().genders),
                  initialValue: genders != null ? selectedGender : null,
                  hint: Text(I18n().selectGender),
                  validators: [FormBuilderValidators.required()],
                  items: genders != null
                      ? genders
                          .map((gender) => DropdownMenuItem(
                              value: gender.id.toString(),
                              child: Text(gender.name.toString())))
                          .toList()
                      : [],
                ),
                Container(
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
                            selectedGender != null
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
    if (championships == null) {
      _onWidgetDidBuild(getChampionships);
    }
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
                  readOnly: selectedGender != null ? false : true,
                  onChanged: (value) => {selectedChampionships = value},
                  attribute: "championship",
                  decoration: InputDecoration(labelText: I18n().championships),
                  initialValue:
                      championships != null ? selectedChampionships : null,
                  hint: Text(I18n().selectChampionship),
                  validators: [FormBuilderValidators.required()],
                  items: championships != null
                      ? championships
                          .map((championship) => DropdownMenuItem(
                              value: championship.id.toString(),
                              child: Text(championship.name.toString())))
                          .toList()
                      : [],
                ),
                Row(
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
                        onPressed: state is! InserimentoLoadingState
                            ? () => goToStep(0)
                            : null,
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
                        onPressed: (state is! InserimentoLoadingState &&
                                selectedChampionships != null)
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
    if (matches == null) {
      _onWidgetDidBuild(getMatches);
    }
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
                  readOnly: selectedGender != null ? false : true,
                  onChanged: (value) => {selectedMatches = value},
                  attribute: "match",
                  decoration: InputDecoration(labelText: I18n().matches),
                  initialValue: matches != null ? selectedMatches : null,
                  hint: Text(I18n().selectMatch),
                  validators: [FormBuilderValidators.required()],
                  items: matches != null
                      ? matches
                          .map((match) => DropdownMenuItem(
                              value: match.id.toString(),
                              child: Text(match.name.toString())))
                          .toList()
                      : [],
                ),
                selectedMatches == "2"
                    ? FormBuilderTypeAhead(
                        decoration: InputDecoration(
                          labelText: I18n().trophies,
                        ),
                        attribute: 'trophy',
                        onChanged: (value) => {searchCategory(value)},
                        onSuggestionSelected: (value) =>
                            {selectedCategories = value},
                        itemBuilder: (context, category) {
                          return ListTile(
                            title: Text(category),
                          );
                        },
                        suggestionsCallback: (query) {
                          if (query.length != 0) {
                            var lowercaseQuery = query.toLowerCase();
                            return categories.where((category) {
                              return category.name
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
                            return categories;
                          }
                        },
                      )
                    : Row(),
                Row(
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
                        onPressed: state is! InserimentoLoadingState
                            ? () => goToStep(1)
                            : null,
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
                        onPressed: (state is! InserimentoLoadingState &&
                                selectedChampionships != null)
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
    if (categories == null) {
      _onWidgetDidBuild(getCategories);
    }
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
                  readOnly: selectedMatches != null ? false : true,
                  onChanged: (value) => {selectedCategories = value},
                  attribute: "cateogry",
                  decoration: InputDecoration(labelText: I18n().categories),
                  initialValue: categories != null ? selectedCategories : null,
                  hint: Text(I18n().selectCategory),
                  validators: [FormBuilderValidators.required()],
                  items: categories != null
                      ? categories
                          .map((cateogry) => DropdownMenuItem(
                              value: cateogry.id.toString(),
                              child: Text(cateogry.name.toString())))
                          .toList()
                      : [],
                ),
                Row(
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
                        onPressed: state is! InserimentoLoadingState
                            ? () => goToStep(2)
                            : null,
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
                        onPressed: (state is! InserimentoLoadingState &&
                                selectedMatches != null)
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
    _controller.animateToPage(
      step,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InserimentoBloc, InserimentoState>(
        bloc: _inserimentoBloc,
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
