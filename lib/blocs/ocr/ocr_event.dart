import 'package:football_system/blocs/model/player_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class OcrEvent {}

class OcrFotoCaptured extends OcrEvent {
  final List<Player> playersName;

  OcrFotoCaptured(this.playersName);
}

class OcrFotoToCapture extends OcrEvent {}

class OcrFotoToCrop extends OcrEvent {
  final String imagePath;
  OcrFotoToCrop(this.imagePath);
}

class OcrFotoCropped extends OcrEvent {
  final String imagePath;
  OcrFotoCropped(this.imagePath);
}
