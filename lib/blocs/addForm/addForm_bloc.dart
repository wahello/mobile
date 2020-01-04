import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:football_system/blocs/addForm/index.dart';
import 'package:football_system/blocs/model/team_model.dart';
import 'package:football_system/blocs/stuff/index.dart';

class AddFormBloc extends Bloc<AddFormEvent, AddFormState> {
  // todo: check singleton for logic in project
  static final AddFormBloc _addFormBlocSingleton = AddFormBloc._internal();
  factory AddFormBloc() {
    return _addFormBlocSingleton;
  }
  AddFormBloc._internal();

  @override
  Future<void> close() async {
    // dispose objects
    super.close();
  }

  AddFormState get initialState => AddFormInitialState();

  @override
  Stream<AddFormState> mapEventToState(
    AddFormEvent event,
  ) async* {}
}
