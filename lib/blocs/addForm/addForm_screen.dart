import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_system/blocs/addForm/addFormModel.dart';
import 'package:football_system/blocs/addForm/addFormSingleInstance.dart';
import 'package:football_system/blocs/incontro/inserimento/index.dart';
import 'package:football_system/blocs/stuff/index.dart';
import 'package:football_system/generated/i18n.dart';

class AddFormScreen extends StatefulWidget {
  final TypeAddForm type;
  final InserimentoBloc bloc;
  final InserimentoState state;
  final String categoryId;
  final String teamId;

  const AddFormScreen(
      {Key key,
      @required this.type,
      @required this.bloc,
      @required this.state,
      this.categoryId,
      this.teamId})
      : super(key: key);
  @override
  AddFormScreenState createState() {
    return AddFormScreenState(type);
  }
}

class AddFormScreenState extends State<AddFormScreen> {
  List<AddFormModel> rows;
  final TypeAddForm type;
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _yearFocus = FocusNode();
  final FocusNode _numberFocus = FocusNode();
  ScrollController _scrollController = new ScrollController();

  String label;
  int maxRows;

  AddFormScreenState(this.type);

//Nell'init creo la lista e la inizializzo con un solo elemento
  @override
  void initState() {
    super.initState();
    rows = new List();

    if (type == TypeAddForm.COACH) {
      label = I18n().newCoach;
      maxRows = 1;
    } else if (type == TypeAddForm.PLAYER) {
      label = I18n().newPlayers;
      maxRows = 11;
    } else if (type == TypeAddForm.TEAM) {
      label = I18n().newTeam;
      maxRows = 1;
    }
  }

  void _addElement(String nome, String number, String anno) {
    if (rows.length < maxRows && (nome?.isNotEmpty ?? false)) {
      rows.add(new AddFormModel(nome: nome, number: number, anno: anno));
    }
  }

  void _removeElement(int index) {
    rows.removeAt(index);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InserimentoBloc, InserimentoState>(
        bloc: widget.bloc,
        listener: (context, state) {
          if (state is InserimentoFormError) {
            final snackBar = SnackBar(content: Text(I18n().erroreGenerico));
            Scaffold.of(context).showSnackBar(snackBar);
          }
          if (state is InserimentoFormSuccess) {
            final snackBar =
                SnackBar(content: Text(I18n().inserimentoCorretto));
            Scaffold.of(context).showSnackBar(snackBar);
            rows.clear();
          }
        },
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  ),
                  Text(
                    label,
                    style: TextStyle(
                        fontSize: 16,
                        decorationStyle: TextDecorationStyle.solid,
                        decoration: TextDecoration.underline),
                  ),
                  rows.length < maxRows
                      ? new Form(
                          key: _formKey,
                          autovalidate: true,
                          child: Column(
                            children: <Widget>[
                              TextField(
                                focusNode: _nameFocus,
                                textInputAction: type != TypeAddForm.PLAYER
                                    ? TextInputAction.done
                                    : TextInputAction.next,
                                decoration:
                                    new InputDecoration(hintText: I18n().nome),
                                controller: _nameController,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                onSubmitted: (text) {
                                  if (type != TypeAddForm.PLAYER) {
                                    _addElement(text, '',
                                        ''); //Valori di default tanto per coach e team non esistono valori
                                    _nameController.clear();
                                  } else {
                                    _fieldFocusChange(
                                        context, _nameFocus, _yearFocus);
                                  }
                                },
                              ),
                              type == TypeAddForm.PLAYER
                                  ? TextField(
                                      focusNode: _yearFocus,
                                      textInputAction: TextInputAction.next,
                                      decoration: new InputDecoration(
                                          hintText: I18n().anno),
                                      controller: _dateController,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      onSubmitted: (text) {
                                        _fieldFocusChange(
                                            context, _yearFocus, _numberFocus);
                                      },
                                    )
                                  : SizedBox.shrink(),
                              type == TypeAddForm.PLAYER
                                  ? TextField(
                                      focusNode: _numberFocus,
                                      textInputAction: TextInputAction.done,
                                      decoration: new InputDecoration(
                                          hintText: I18n().numero),
                                      controller: _numberController,
                                      onSubmitted: (value) {
                                        _numberFocus.unfocus();
                                      },
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                    )
                                  : SizedBox.shrink(),
                              FlatButton(
                                child: Icon(Icons.add),
                                onPressed: () {
                                  _addElement(
                                      _nameController.text,
                                      _numberController.text,
                                      _dateController.text);
                                  _nameController.clear();
                                  _numberController.clear();
                                  _dateController.clear();
                                  _scrollController.animateTo(
                                    0.0,
                                    curve: Curves.easeOut,
                                    duration: const Duration(milliseconds: 300),
                                  );
                                },
                              ),
                            ],
                          ))
                      : SizedBox.shrink(),
                  SingleChildScrollView(
                      child: Column(
                    children: <Widget>[
                      ListView.builder(
                          controller: _scrollController,
                          itemCount: rows.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext ctxt, int index) {
                            String name = rows[index].toString();
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(name),
                                FlatButton(
                                  child: Icon(Icons.remove),
                                  onPressed: () {
                                    _removeElement(index);
                                  },
                                )
                              ],
                            );
                          }),
                      rows.length > 0
                          ? widget.state is InserimentoLoadingState
                              ? Container(
                                  margin: const EdgeInsets.only(top: 20.0),
                                  child: LoadingIndicator(),
                                )
                              : FlatButton(
                                  onPressed: _submitForm,
                                  child: Icon(Icons.done),
                                )
                          : SizedBox.shrink()
                    ],
                  ))
                ])));
  }

  void _submitForm() {
    widget.bloc
        .add(SubmitFormEvent(rows, type, widget.categoryId, widget.teamId));
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
