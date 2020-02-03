import 'package:equatable/equatable.dart';

abstract class OcrState extends Equatable {

}

class OcrInitialState extends OcrState {

}

class OcrFotoToCapture extends OcrState {
  
}

class OcrCaptureFoto extends OcrState{
  final List<String> playersName;

  OcrCaptureFoto(this.playersName);
}

