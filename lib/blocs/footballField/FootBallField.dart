import 'package:football_system/blocs/model/player_model.dart';

class FootballField {
  //lista giocatori campo
  List<List<Player>> players;
  List<int> dimension;
  List<String> positions;

  FootballField({this.dimension, this.players, this.positions}) {
    players = List.generate(
        dimension[0], (_) => List.generate(dimension[1], (_) => null));

    for (var position in positions) {
      List<String> xy = position[0].split(",");

      int x = int.parse(xy[0]);
      int y = int.parse(xy[1]);

      players[x][y] = Player(
          id: 0, name: "", numero: "", posizione: position[0], ruolo: "");
    }
  }
}
