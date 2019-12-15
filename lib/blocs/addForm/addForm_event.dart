import 'dart:async';
import 'dart:developer' as developer;

import 'package:football_system/blocs/addForm/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AddFormEvent {}

class LoadAddFormEvent extends AddFormEvent {
  @override
  String toString() => 'LoadAddFormEvent';
}
