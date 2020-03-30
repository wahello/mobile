import 'package:football_system/blocs/incontro/inserimento/index.dart';

class OCRPageArgument {
  final bool isHome;
  final String categoryId;
  final String teamId;
  final InserimentoBloc inserimentoBloc;

  OCRPageArgument(
      this.isHome, this.categoryId, this.teamId, this.inserimentoBloc);
}
