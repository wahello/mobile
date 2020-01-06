import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_system/blocs/addForm/addFormSingleInstance.dart';
import 'package:football_system/blocs/incontro/inserimento/index.dart';
import 'package:football_system/blocs/stuff/index.dart';
import 'package:football_system/generated/i18n.dart';

class AddFormScreen extends StatefulWidget {
  final TypeAddForm type;
  final InserimentoBloc bloc;
  final InserimentoState state;
  final String categoryId;

  const AddFormScreen(
      {Key key,
      @required this.type,
      @required this.bloc,
      @required this.state,
      this.categoryId})
      : super(key: key);
  @override
  AddFormScreenState createState() {
    return AddFormScreenState(type);
  }
}

class AddFormScreenState extends State<AddFormScreen> {
  List<Text> rows;
  final TypeAddForm type;
  final _controller = TextEditingController();

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

  void _addElement(String text) {
    if (rows.length < maxRows && (text?.isNotEmpty ?? false)) {
      rows.add(new Text(text));
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
                  ? Column(
                      children: <Widget>[
                        TextField(
                          controller: _controller,
                          textCapitalization: TextCapitalization.sentences,
                          onSubmitted: (text) {
                            _addElement(text);
                            _controller.clear();
                          },
                        ),
                        FlatButton(
                          child: Icon(Icons.add),
                          onPressed: () {
                            _addElement(_controller.text);
                            _controller.clear();
                          },
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
              SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  ListView.builder(
                      itemCount: rows.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext ctxt, int index) {
                        String name = rows[index].data;
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
            ]));
  }

  void _submitForm() {
    widget.bloc.add(SubmitFormEvent(rows, type, widget.categoryId));
  }
}
