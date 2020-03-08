import 'package:equatable/equatable.dart';
import 'package:football_system/blocs/model/player_model.dart';

abstract class OcrState extends Equatable {}

class OcrInitialState extends OcrState {}

class OcrFotoToCaptureState extends OcrState {}

class OcrFotoToCropState extends OcrState {
  final String imagePath;

  OcrFotoToCropState(this.imagePath);
}

class OcrCapturedFoto extends OcrState {
  final List<Player> playersName;

  OcrCapturedFoto(this.playersName);
}

class OcrFotoCroppedState extends OcrState {
  final String imagePath;

  OcrFotoCroppedState(this.imagePath);
}
