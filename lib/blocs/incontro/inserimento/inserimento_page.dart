import 'package:flutter/material.dart';
import 'package:football_system/blocs/incontro/inserimento/index.dart';
import 'package:football_system/blocs/stuff/calls_repository.dart';
import 'package:football_system/blocs/user/index.dart';
import 'package:football_system/generated/i18n.dart';

class InserimentoPage extends StatefulWidget {
  final UserRepository userRepository;
  final CallsRepository callsRepository;
  final Function(String) notifyParent;

  InserimentoPage(
      {Key key,
      this.notifyParent,
      @required this.userRepository,
      @required this.callsRepository})
      : assert(userRepository != null && callsRepository != null),
        super(key: key);

  @override
  State<InserimentoPage> createState() => _InserimentoPageState();
}

class _InserimentoPageState extends State<InserimentoPage> {
  InserimentoBloc inserimentoBloc;
  @override
  void initState() {
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    widget.notifyParent(I18n().inserimentoIncontro);
    return InserimentoScreen(inserimentoBloc: inserimentoBloc);
  }

  @override
  void dispose() {
    inserimentoBloc.close();
    super.dispose();
  }
}
