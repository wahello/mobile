import 'package:football_system/blocs/addForm/addFormSingleInstance.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AddFormEvent {}

class LoadAddFormEvent extends AddFormEvent {
  @override
  String toString() => 'LoadAddFormEvent';
}
