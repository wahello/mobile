import 'package:equatable/equatable.dart';
import 'package:football_system/blocs/model/addFormModel.dart';
import 'package:football_system/blocs/addForm/addFormSingleInstance.dart';
import 'package:meta/meta.dart';

abstract class InserimentoEvent extends Equatable {
  const InserimentoEvent([List props = const []]) : super(props);
}

class InserimentoStarted extends InserimentoEvent {
  @override
  String toString() => 'InserimentoStarted';
}

class SubmitFormEvent extends InserimentoEvent {
  final List<AddFormModel> dataToSend;
  final TypeAddForm type;
  final String categoryId;
  final String teamId;
  final bool isHome;

  SubmitFormEvent(
      this.dataToSend, this.type, this.categoryId, this.teamId, this.isHome);

  @override
  String toString() => 'SubmitFormEvent';
}

class InserimentoLoadingEvent extends InserimentoEvent {
  @override
  String toString() {
    return 'InserimentoLoadingEvent';
  }
}

class InserimentoFinishEvent extends InserimentoEvent {
  @override
  String toString() {
    return 'InserimentoFinishEvent';
  }
}

class GetGendersEvent extends InserimentoEvent {
  @override
  String toString() {
    return 'GetGendersEvent';
  }
}

class GetChampionshipsEvent extends InserimentoEvent {
  @override
  String toString() {
    return 'GetChampionshipsEvent';
  }
}

class GetMatchesEvent extends InserimentoEvent {
  @override
  String toString() => 'GetMatchesEvent';
}

class GetCategoriesEvent extends InserimentoEvent {
  @override
  String toString() => 'GetCategoriesEvent';
}

class GetTeamsEventHome extends InserimentoEvent {
  @override
  String toString() => 'GetTeamsEventHome';
}

class GetTeamsEventAway extends InserimentoEvent {
  @override
  String toString() => 'GetTeamsEventAway';
}

class GetTournamentsEvent extends InserimentoEvent {
  final String inputTextValue;

  GetTournamentsEvent({
    @required this.inputTextValue,
  }) : super([inputTextValue]);

  @override
  String toString() =>
      'GetTournamentsEvent { inputTextValue: $inputTextValue }';
}

class GetPlayersEventHome extends InserimentoEvent {
  @override
  String toString() => 'GetPlayersEventHome';
}

class GetPlayersEventAway extends InserimentoEvent {
  @override
  String toString() => 'GetPlayersEventAway';
}

class GetCoachesEventHome extends InserimentoEvent {
  @override
  String toString() => 'GetCoachesEventHome';
}

class GetCoachesEventAway extends InserimentoEvent {
  @override
  String toString() => 'GetCoachesEventAway';
}

class InserisciIncontroEvent extends InserimentoEvent {
  @override
  String toString() => 'InserisciIncontroEvent';
}

class InserisciModuloEventHome extends InserimentoEvent {
  @override
  String toString() => 'InserisciModuloEventHome';
}

class ChooseJerseyEvent extends InserimentoEvent {
  @override
  String toString() => 'ChooseJerseyEvent';
}

class InserisciModuloEventAway extends InserimentoEvent {
  @override
  String toString() => 'InserisciModuloEventAway';
}

class SaveMatchEvent extends InserimentoEvent {
  @override
  String toString() => 'SaveMatchEvent';
}
