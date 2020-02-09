import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:football_system/blocs/authentication/authentication_bloc.dart';
import 'package:football_system/blocs/authentication/index.dart';
import 'package:football_system/generated/i18n.dart';
import 'package:shared/shared.dart';

import 'keys.dart';

class CustomPage extends StatefulWidget {
  Key key;
  AuthenticationBloc authenticationBloc;
  Widget appBarTitleText = new Text(I18n().appName);
  List<Widget> actions = [];
  Widget child;

  CustomPage(
      {this.key,
      this.authenticationBloc,
      this.appBarTitleText,
      this.actions,
      this.child});

  @override
  _CustomPageState createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage> {
  Key get key => widget.key;
  AuthenticationBloc get authenticationBloc => widget.authenticationBloc;
  Widget get appBarTitleText => widget.appBarTitleText;
  List<Widget> get actions => widget.actions;
  Widget get child => widget.child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
        persistentFooterButtons: <Widget>[
          FloatingActionButton(
            backgroundColor: MainColors.PRIMARY,
            child: Icon(Icons.home),
            heroTag: "home",
            onPressed: () => {authenticationBloc.add(GoHome())},
          ),
          Divider(
            indent: MediaQuery.of(context).size.width / 2.65,
          ),
        ],
        appBar: AppBar(
          leading: FlatButton(
            key: FormKey.logoutKey,
            child: Icon(Icons.exit_to_app),
            onPressed: () => {authenticationBloc.add(LoggedOut())},
          ),
          title: appBarTitleText,
          actions: actions,
          backgroundColor: MainColors.PRIMARY,
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: MainColors.SECONDARY,
            ),
            child: Container(padding: EdgeInsets.all(3.0), child: child)));
  }
}
