import 'package:equatable/equatable.dart';

abstract class OcrState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  OcrState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  OcrState getStateCopy();

  OcrState getNewVersion();

  @override
  List<Object> get props => (propss);
}

/// UnInitialized
class UnOcrState extends OcrState {

  UnOcrState(int version) : super(version);

  @override
  String toString() => 'UnOcrState';

  @override
  UnOcrState getStateCopy() {
    return UnOcrState(0);
  }

  @override
  UnOcrState getNewVersion() {
    return UnOcrState(version+1);
  }
}

/// Initialized
class InOcrState extends OcrState {
  final String hello;

  InOcrState(int version, this.hello) : super(version, [hello]);

  @override
  String toString() => 'InOcrState $hello';

  @override
  InOcrState getStateCopy() {
    return InOcrState(this.version, this.hello);
  }

  @override
  InOcrState getNewVersion() {
    return InOcrState(version+1, this.hello);
  }
}

class ErrorOcrState extends OcrState {
  final String errorMessage;

  ErrorOcrState(int version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorOcrState';

  @override
  ErrorOcrState getStateCopy() {
    return ErrorOcrState(this.version, this.errorMessage);
  }

  @override
  ErrorOcrState getNewVersion() {
    return ErrorOcrState(version+1, this.errorMessage);
  }
}
