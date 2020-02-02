import 'dart:async';
import 'dart:developer' as developer;

import 'package:football_system/blocs/ocr/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class OcrEvent {
  Future<OcrState> applyAsync({OcrState currentState, OcrBloc bloc});
}
