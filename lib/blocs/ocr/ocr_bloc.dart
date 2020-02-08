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
  OcrState get initialState => OcrInitialState();

  @override
  Stream<OcrState> mapEventToState(
    OcrEvent event,
  ) async* {
    try {
      if (event is OcrFotoCaptured) {
        yield OcrCapturedFoto(event.playersName);
      }
      if (event is OcrFotoToCrop) {
        yield OcrFotoToCropState(event.imagePath);
      }
      if (event is OcrFotoCropped) {
        yield OcrFotoCroppedState(event.imagePath);
      }
    } catch (_, stackTrace) {
      developer.log('$_', name: 'OcrBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
