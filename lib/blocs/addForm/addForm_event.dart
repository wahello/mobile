import 'package:meta/meta.dart';

@immutable
abstract class AddFormEvent {}

class LoadAddFormEvent extends AddFormEvent {
  @override
  String toString() => 'LoadAddFormEvent';
}

class SubmitFormEvent extends AddFormEvent {
  final List dataToSend;

  SubmitFormEvent(this.dataToSend);

  @override
  String toString() => 'SubmitFormEvent';
}
