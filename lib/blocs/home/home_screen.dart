import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_system/blocs/home/index.dart';
import 'package:football_system/generated/i18n.dart';
import 'package:shared/shared.dart';

import '../authentication/index.dart';

class HomeScreen extends StatelessWidget {
  Card makeDashboardItem(String title, IconData icon, Function click) {
    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: MainColors.PRIMARY),
          child: new InkWell(
            onTap: click,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                  icon,
                  size: 40.0,
                  color: MainColors.TEXT_NEGATIVE,
                )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style: new TextStyle(
                          fontSize: 18.0, color: MainColors.TEXT_NEGATIVE)),
                ),
                SizedBox(height: 50.0),
              ],
            ),
          ),
        ));
  }

  _onModificaButtonPressed() {}
  _onFormazioneButtonPressed() {}

  @override
  Widget build(BuildContext context) {
    return _body(
        authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
        homeBloc: BlocProvider.of<HomeBloc>(context),
        context: context);
  }

  Widget _body(
      {AuthenticationBloc authenticationBloc,
      HomeBloc homeBloc,
      BuildContext context}) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: MainColors.SECONDARY,
      ),
      child: ListView(
        padding: EdgeInsets.all(3.0),
        children: <Widget>[
          makeDashboardItem(I18n().inserisciIncontro, Icons.insert_invitation,
              () => {homeBloc.add(InserimentoIncontroEvent())}),
          makeDashboardItem(
              I18n().modificaIncontro, Icons.edit, _onModificaButtonPressed),
          makeDashboardItem(I18n().inserisciFormazioneTipo, Icons.people,
              _onFormazioneButtonPressed),
        ],
      ),
    );
  }
}
