import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:football_system/blocs/ocr/index.dart';

class OcrBloc extends Bloc<OcrEvent, OcrState> {
  // todo: check singleton for logic in project
  static final OcrBloc _ocrBlocSingleton = OcrBloc._internal();
  factory OcrBloc() {
    return _ocrBlocSingleton;
  }
  OcrBloc._internal();

  @override
  Future<void> close() async {
    // dispose objects
    super.close();
  }

  @override
  OcrState get initialState => UnOcrState(0);

  @override
  Stream<OcrState> mapEventToState(
    OcrEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'OcrBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
