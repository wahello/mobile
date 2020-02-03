import 'package:meta/meta.dart';

@immutable
abstract class OcrEvent {}

class OcrFotoCaptured extends OcrEvent {
  final List<String> playersName;

  OcrFotoCaptured(this.playersName);
}
