import 'package:football_system/blocs/model/player_model.dart';

class FootballField {
  final int category;

  //campo da gioco
  List<List<Player>> matrix;
  //lista giocatori da piazzare
  //ogni qual volta si schiera un giocatore nel campo , questo viene rimosso dalla lista
  List<Player> players;

  FootballField({this.category, this.players}) {
    matrix = List.generate(category, (_) => List<Player>(category));

    clearField();
  }

  /*
  usage: 
    FootballField footballField = FootballField(11,11);
    Player occupato = footballField['1,1'];
   */

  operator [](String xy) {
    List<String> XY = xy.split(',');

    int x = int.parse(XY[0]);
    int y = int.parse(XY[1]);

    return matrix[x][y];
  }

  /*
  usage: 
    FootballField footballField = FootballField(11,11);
    footballField['1,1'] = Player();
   */
  operator []=(String xy, Player value) {
    List<String> XY = xy.split(',');

    int x = int.parse(XY[0]);
    int y = int.parse(XY[1]);

    matrix[x][y] = value;
  }

  void clearField() {
    matrix.forEach((row) => {
          row.forEach((value) => {value = null})
        });
  }
}
