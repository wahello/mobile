import 'package:meta/meta.dart';

@immutable
abstract class AddFormEvent {}

class LoadAddFormEvent extends AddFormEvent {
  @override
  String toString() => 'LoadAddFormEvent';
}
