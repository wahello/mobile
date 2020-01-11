import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_system/blocs/incontro/inserimento/index.dart';
import 'package:football_system/blocs/incontro/inserimento/keys.dart';
import 'package:shared/shared.dart';

class FootballFieldPageNew extends StatefulWidget {
  InserimentoBloc inserimentoBloc;

  FootballFieldPageNew({this.inserimentoBloc});

  @override
  _FootballFieldPageNewState createState() =>
      _FootballFieldPageNewState(inserimentoBloc: inserimentoBloc);
}

class _FootballFieldPageNewState extends State<FootballFieldPageNew> {
  final int rows = 9;
  final int columns = 11;

  ViewBloc viewBloc;
  InserimentoBloc inserimentoBloc;

  _FootballFieldPageNewState({this.inserimentoBloc}) {
    List<List<PlayerModel>> positions = List<List<PlayerModel>>.generate(
        9, (_) => List<PlayerModel>.generate(11, (_) => null));

    for (var position in inserimentoBloc.incontro.module.positions) {
      List<String> xy = position.split(",");
      int x = int.parse(xy[0]);
      int y = int.parse(xy[1]);

      positions[x][y] = PlayerModel(
        name: "",
        number: "",
        xPosition: xy[0],
        yPosition: xy[1],
      );
    }
    viewBloc = ViewBloc(positions: positions);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildPositions(ViewBloc viewBloc) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: List.generate(
            rows,
            (i) => Row(
                  children: List.generate(
                      columns,
                      (j) => Position(
                            bloc: viewBloc,
                            x: i,
                            y: j,
                          )),
                )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewBloc, int>(
      bloc: viewBloc,
      builder: (context, state) {
        print(state);
        return Scaffold(
            body: Center(
                child: Stack(
          children: <Widget>[buildFootballField(), buildPositions(viewBloc)],
        )));
      },
    );
  }

  Widget buildFootballField() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              // fit: BoxFit.fill,
              image: AssetImage('assets/images/football_field.jpg'))),
    );
  }
}

class PlayerModel extends StatelessWidget {
  String name = "someplayer";
  String number = "95";
  String xPosition;
  String yPosition;
  ViewBloc viewBloc;

  PlayerModel(
      {this.viewBloc, this.name, this.number, this.xPosition, this.yPosition});

  @override
  Widget build(BuildContext context) {
    var player = Stack(alignment: Alignment.center, children: <Widget>[
      GestureDetector(
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Scaffold(
                    appBar: AppBar(
                      backgroundColor: MainColors.PRIMARY,
                    ),
                    body: Container())),
          )
        },
        child: Container(
            width: MediaQuery.of(context).size.width / 5,
            // margin: EdgeInsets.only(top: 40),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                      'assets/images/maglia.png',
                    ))),
                  ),
                  name != '' && number != ''
                      ? Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1)),
                          child: Column(
                            children: <Widget>[
                              Text(number,
                                  style: TextStyle(
                                      fontSize: 9.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              Text(
                                name,
                                style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        )
                      : Container()
                ],
              ),
            )),
      ),
    ]);
    return Draggable(
        child: player,
        feedback: player,
        childWhenDragging: Container(),
        onDragCompleted: () {},
        onDraggableCanceled: (velocity, offset) {
          // print(lost);
          // int x = int.parse(lost.xPosition);
          // int y = int.parse(lost.yPosition);
          // positions[x][y] = lost;
          // viewBloc.add(ViewEvent.refreshed);
        },
        data: [name, number, xPosition, yPosition]);
  }
}

class Position extends StatefulWidget {
  int x;
  int y;
  ViewBloc bloc;

  Position({this.x, this.y, this.bloc});
  @override
  State<StatefulWidget> createState() {
    return PositionState(bloc: bloc);
  }
}

class PositionState extends State<Position> {
  ViewBloc bloc;
  PositionState({this.bloc});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewBloc, int>(
      bloc: bloc,
      builder: (context, state) {
        return Expanded(
            child: DragTarget(
          builder: (context, List<List<String>> candidateData, rejectedData) {
            return buildFootballPlayer(
                bloc, widget.x, widget.y, MediaQuery.of(context).size);
          },
          onWillAccept: (data) {
            return false;
          },
          onAccept: (data) {
            int oldX = int.parse(data[2]);
            int oldY = int.parse(data[3]);
            if (oldX != widget.x || oldY != widget.y) {
              widget.bloc.positions[widget.x][widget.y] = PlayerModel(
                name: data[0],
                number: data[1],
              );
            }
          },
          onLeave: (data) {
            // int oldX = int.parse(data[2]);
            // int oldY = int.parse(data[3]);

            // lost = PlayerModel(
            //     name: data[0],
            //     number: data[1],
            //     xPosition: data[2],
            //     yPosition: data[3]);

            // positions[oldX][oldY] = null;
          },
        ));
      },
    );
  }

  Widget buildFootballPlayer(ViewBloc bloc, int x, int y, Size screenSize) {
    var returnValue = null;
    if (bloc.positions[x][y] != null) {
      returnValue = PlayerModel(
        viewBloc: bloc,
        name: bloc.positions[x][y].name,
        number: bloc.positions[x][y].number,
        xPosition: x.toString(),
        yPosition: y.toString(),
      );
    } else {
      returnValue = Container(
        width: screenSize.width / 11,
        height: screenSize.height / 10.5,
        decoration: BoxDecoration(color: Colors.transparent),
      );
    }
    return returnValue;
  }
}

enum ViewEvent { created, refreshed }

class ViewBloc extends Bloc<ViewEvent, int> {
  List<List<PlayerModel>> positions;

  ViewBloc({this.positions});

  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(ViewEvent event) async* {
    switch (event) {
      case ViewEvent.created:
      case ViewEvent.refreshed:
        yield 1;
        break;
    }
  }
}
