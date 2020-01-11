import 'package:football_system/blocs/model/player_model.dart';

class FootballField {
  //lista giocatori campo
  List<List<Player>> players;
  List<int> dimension;
  List<List<String>> positions;

  FootballField({this.dimension, this.players, this.positions}) {
    players = List<List<Player>>.generate(
        dimension[0], (_) => List<Player>(dimension[1]));

    for (int i = 0; i < positions.length; i++) {
      List<String> xy = positions[i][0].split(",");

      int x = int.parse(xy[0]) - 1;
      int y = int.parse(xy[1]);

      players[y][x] = Player(
          id: 0,
          name: "aggiungi",
          numero: "",
          posizione: positions[i][0],
          ruolo: "");
    }
  }
}
