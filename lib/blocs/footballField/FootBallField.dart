class FootballField {
  final int rows;
  final int columns;

  List<List<int>> matrix;

  FootballField({this.rows, this.columns}) {
    matrix = List.generate(rows, (_) => List<int>(columns));

    clearField();
  }

  /*
  usage: 
    FootballField footballField = FootballField(11,11);
    int occupato = footballField['1,1'];
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
    int occupato = footballField['1,1'];
   */
  operator []=(String xy, int value) {
    List<String> XY = xy.split(',');

    int x = int.parse(XY[0]);
    int y = int.parse(XY[1]);

    matrix[x][y] = value;
  }

  void clearField() {
    matrix.forEach((row) => {
          row.forEach((value) => {value = 0})
        });
  }
}
