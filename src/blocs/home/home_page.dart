import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../const/colors.dart';
import '../authentication/authentication_bloc.dart';
import '../authentication/index.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: MainColors.PRIMARY,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: MainColors.SECONDARY,
        ),
        padding: EdgeInsets.all(120.0),
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(top: 250.0),
                child: Center(
                  child: Text(
                    'BENVENUTO!',
                    style: TextStyle(
                      color: MainColors.PRIMARY,
                    ),
                    textScaleFactor: 2,
                  ),
                )),
            Container(
              padding: EdgeInsets.only(top: 150.0),
              child: Center(
                child: new FlatButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  color: MainColors.PRIMARY,
                  onPressed: () {
                    authenticationBloc.dispatch(LoggedOut());
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
                            "LOGOUT",
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
      ),
    );
  }
}
