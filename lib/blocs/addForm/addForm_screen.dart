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
  List<AddFormSingle> rows;
  final TypeAddForm type;

  AddFormScreenState(this.type);

//Nell'init creo la lista e la inizializzo con un solo elemento
  @override
  void initState() {
    super.initState();
    rows = new List();
    rows.add(new AddFormSingle(
      type: type,
    ));
  }

  void _addElement() {
    rows.add(new AddFormSingle(
      type: type,
    ));
  }

  void _removeElement() {
    rows.removeAt(rows.length - 1);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddFormBloc, AddFormState>(builder: (
      BuildContext context,
      AddFormState currentState,
    ) {
      return Column(children: [
        Text('Aggiungi elementi'),
        Row(
          children: <Widget>[
            FlatButton(
              child: Icon(Icons.plus_one),
              onPressed: _addElement,
            ),
            FlatButton(
              child: Icon(Icons.delete),
              onPressed: _removeElement,
            )
          ],
        ),
        ListView.builder(
            itemCount: rows.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return rows[index];
            })
      ]);
    });
  }
}
