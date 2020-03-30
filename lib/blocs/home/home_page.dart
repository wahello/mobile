import 'package:flutter/material.dart';
import 'package:football_system/blocs/authentication/authentication_bloc.dart';
import 'package:football_system/generated/i18n.dart';

import 'index.dart';

class HomePage extends StatefulWidget {
  AuthenticationBloc authenticationBloc;
  final Function(Widget) notifyParent;
  final Function(Widget) notifyAction;

  HomePage(
      {Key key, this.authenticationBloc, this.notifyParent, this.notifyAction})
      : super(key: key);

  @override
  State<HomePage> createState() =>
      _HomePageState(authenticationBloc: authenticationBloc);
}

class _HomePageState extends State<HomePage> {
  AuthenticationBloc authenticationBloc;

  _HomePageState({this.authenticationBloc});
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.notifyParent(Text(I18n().inserimentoIncontro));
    widget.notifyAction(null);
    return HomeScreen(authenticationBloc: authenticationBloc);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
