import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_system/blocs/stuff/calls_repository.dart';

import '../authentication/authentication_bloc.dart';
import '../user/user_repository.dart';
import 'index.dart';

class LoginPage extends StatefulWidget {
  final UserRepository userRepository;
  final CallsRepository callsRepository;

  LoginPage(
      {Key key, @required this.userRepository, @required this.callsRepository})
      : assert(userRepository != null && callsRepository != null),
        super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;
  AuthenticationBloc _authenticationBloc;

  UserRepository get _userRepository => widget.userRepository;
  CallsRepository get _callsRepository => widget.callsRepository;

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _loginBloc = LoginBloc(
      userRepository: _userRepository,
      callsRepository: _callsRepository,
      authenticationBloc: _authenticationBloc,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: LoginForm(
          authenticationBloc: _authenticationBloc,
          loginBloc: _loginBloc,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginBloc.close();
    _authenticationBloc.close();
    super.dispose();
  }
}
