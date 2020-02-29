import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football_system/blocs/addForm/addFormModel.dart';
import 'package:football_system/blocs/addForm/addFormSingleInstance.dart';
import 'package:football_system/blocs/incontro/inserimento/index.dart';
import 'package:shared/shared.dart';

class OcrListPlayers extends StatefulWidget {
  final List<String> playersToShow;
  final InserimentoBloc bloc;
  final String categoryId;
  final String teamId;
  final bool isHome;

  const OcrListPlayers({
    Key key,
    @required this.playersToShow,
    @required this.bloc,
    @required this.categoryId,
    @required this.teamId,
    @required this.isHome,
  }) : super(key: key);

  @override
  OcrListPlayerState createState() {
    return OcrListPlayerState();
  }
}

class OcrListPlayerState extends State<OcrListPlayers> {
  ScrollController _scrollController;

  void changePlayer(String newValue, int index) {
    widget.playersToShow[index] = newValue;
  }

  List<AddFormModel> createList() {
    List<AddFormModel> list = new List();
    for (String name in widget.playersToShow) {
      list.add(new AddFormModel(nome: name));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.playersToShow.length > 0) {
      return SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: <Widget>[
              Text(
                'Giocatori da inserire',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                  primary: false,
                  controller: _scrollController,
                  itemCount: widget.playersToShow.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext ctxt, int index) {
                    String name = widget.playersToShow[index].toString();
                    return TextFormField(
                      initialValue: name ?? '',
                      onChanged: (newValue) {
                        changePlayer(newValue, index);
                      },
                    );
                  }),
              StyledButtonWidget(
                hint: 'Submit',
                onPressed: () {
                  widget.bloc.add(SubmitFormEvent(
                      createList(),
                      TypeAddForm.PLAYER,
                      widget.categoryId,
                      widget.teamId,
                      widget.isHome));
                },
              )
            ],
          ));
    } else {
      return Container();
    }
  }
}
