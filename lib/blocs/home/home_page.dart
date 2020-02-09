import 'package:flutter/material.dart';
import 'package:football_system/blocs/authentication/authentication_bloc.dart';

import 'index.dart';

class HomePage extends StatefulWidget {
  AuthenticationBloc authenticationBloc;

  HomePage({Key key, this.authenticationBloc}) : super(key: key);

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
    return HomeScreen(authenticationBloc: authenticationBloc);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
