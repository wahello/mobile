import 'package:football_system/blocs/model/player_model.dart';

class FootballField {
  //lista giocatori campo
  List<Player> players;
  List<int> dimension;

  FootballField({this.dimension, this.players}) {
    players = List<Player>(dimension[0] * dimension[1]);
  }
}
