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
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
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
                  color: Colors.black,
                )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style:
                          new TextStyle(fontSize: 18.0, color: Colors.black)),
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
          makeDashboardItem(I18n().inserisciIncontro, Icons.book,
              () => {homeBloc.add(InserimentoIncontroEvent())}),
          makeDashboardItem(
              I18n().modificaIncontro, Icons.alarm, _onModificaButtonPressed),
          makeDashboardItem(I18n().inserisciFormazioneTipo, Icons.alarm,
              _onFormazioneButtonPressed),
          Container(
            child: Center(
              child: new FlatButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                color: MainColors.PRIMARY,
                onPressed: () {
                  authenticationBloc.add(LoggedOut());
                },
                child: new Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 20.0,
                  ),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Expanded(
                        child: Text(
                          I18n().logout,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: MainColors.TEXT_NEGATIVE,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
