class Field {
  static final int rows = 13;
  static final int columns = 9;
  List<List<int>> matrix;
  Field() {
    matrix = List.generate(rows, (_) => List(columns));
    int k = 0;
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        matrix[i][j] = k++;
      }
    }
  }
  int getPosition(int x, int y) {
    return matrix[x][y];
  }
}
