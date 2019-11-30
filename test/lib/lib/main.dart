import 'package:flutter/material.dart';
import 'package:football_field/presentation/soccerplayer_icons.dart';

import 'fieldRow.dart';
import 'module.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var all_positions = List.generate(21, (_) => List<int>(11));

  List<Module> moduli = null;
  String modulo_scelto;
  Module module;

  _MyHomePageState() {
    _callGetModules().then((value) => _setModules(value));
  }

  void _setModules(List<Module> value) {
    setState(() {
      this.moduli = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            (moduli != null)
                ? DropdownButton<String>(
                    value: modulo_scelto ?? moduli[0].name,
                    items: moduli
                        .map((modulo) => DropdownMenuItem(
                              value: modulo.name,
                              child: Text(modulo.name),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        modulo_scelto = value;
                        module = moduli
                            .where((_module) => _module.name == value)
                            .first;
                      });
                    },
                  )
                : Container()
          ],
        ),
        body: Center(
            child: Stack(children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/campo-di-calcio-1.jpg'))),
          ),
          Container(
            margin: EdgeInsets.all(45),
            child: buildFootballField(module),
          )
        ])));
  }

  Widget buildFootballField(Module modulo) {
    for (int i = 0; i < all_positions.length; i++) {
      for (int j = 0; j < all_positions[i].length; j++) {
        all_positions[i][j] = 0;
      }
    }
    if (modulo == null) {
      return Container();
    } else {
      putPlayers(all_positions, modulo.fieldPostion);
      return Column(
        children: all_positions
            .map((row) => FieldRow(
                  children: row,
                ))
            .toList(),
      );
    }
  }

  void putPlayers(
      List<List<int>> all_positions, List<List<int>> module_positions) {
    for (int i = 0; i < module_positions.length; i++) {
      all_positions[module_positions[i][0]][module_positions[i][1]] = 1;
    }
  }

  //GET : LISTA DEI MODULI
  Future<List<Module>> _callGetModules() async {
    return await Future.delayed(
        Duration(seconds: 3),
        () => [
              Module(name: ''),
              Module(name: '4-4-2', fieldPostion: [
                [20, 5],
                [18, 3],
                [18, 7],
                [15, 1],
                [15, 9],
                [10, 3],
                [10, 7],
                [7, 1],
                [7, 9],
                [2, 3],
                [2, 7]
              ]),
              Module(name: '4-3-3', fieldPostion: [
                [20, 5],
                [18, 3],
                [18, 7],
                [15, 1],
                [15, 9],
                [9, 2],
                [9, 8],
                [10, 5],
                [2, 1],
                [2, 9],
                [0, 5]
              ])
            ].toList());
  }
}
