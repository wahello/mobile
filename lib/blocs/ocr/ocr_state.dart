import 'package:equatable/equatable.dart';

abstract class OcrState extends Equatable {}

class OcrInitialState extends OcrState {}

class OcrFotoToCapture extends OcrState {}

class OcrFotoToCropState extends OcrState {
  final String imagePath;

  OcrFotoToCropState(this.imagePath);
}

class OcrCapturedFoto extends OcrState {
  final List<String> playersName;

  OcrCapturedFoto(this.playersName);
}

class OcrFotoCroppedState extends OcrState {
  final String imagePath;

  OcrFotoCroppedState(this.imagePath);
}
