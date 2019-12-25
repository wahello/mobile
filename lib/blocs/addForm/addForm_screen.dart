import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_system/blocs/addForm/addFormSingleInstance.dart';
import 'package:football_system/blocs/addForm/index.dart';

class AddFormScreen extends StatefulWidget {
  final TypeAddForm type;

  const AddFormScreen({Key key, this.type}) : super(key: key);
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
      label = 'Aggiungi allenatore';
      maxRows = 1;
    } else if (type == TypeAddForm.PLAYER) {
      label = 'Aggiungi giocatori';
      maxRows = 11;
    } else if (type == TypeAddForm.TEAM) {
      label = 'Aggiungi squadra';
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
    return BlocBuilder<AddFormBloc, AddFormState>(
        bloc: AddFormBloc(),
        builder: (
          BuildContext context,
          AddFormState currentState,
        ) {
          return Column(
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
                Column(
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
                ),
                SingleChildScrollView(
                    child: Column(
                  children: <Widget>[
                    ListView.builder(
                        itemCount: rows.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext ctxt, int index) {
                          String name = rows[index].data;
                          return Flex(
                              direction: Axis.horizontal,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text('Name: $name'),
                                    FlatButton(
                                      child: Icon(Icons.remove),
                                      onPressed: () {
                                        _removeElement(index);
                                      },
                                    )
                                  ],
                                )
                              ]);
                        }),
                    rows.length > 0
                        ? FlatButton(
                            onPressed: _submitForm,
                            child: Icon(Icons.done),
                          )
                        : SizedBox.shrink()
                  ],
                ))
              ]);
        });
  }

  void _submitForm() {}
}
