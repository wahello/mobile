import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_system/generated/i18n.dart';
import 'package:shared/shared.dart';

import '../authentication/index.dart';
import '../stuff/loading_indicator.dart';
import 'index.dart';

class LoginForm extends StatefulWidget {
  LoginForm({
    Key key,
    @required this.loginBloc,
    @required this.authenticationBloc,
  }) : super(key: key);

  final AuthenticationBloc authenticationBloc;
  final LoginBloc loginBloc;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with TickerProviderStateMixin {
  final _controller = PageController(initialPage: 0, viewportFraction: 1.0);

  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  final _passwordController = TextEditingController();
  final _samePasswordController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  LoginBloc get _loginBloc => widget.loginBloc;

  Widget homePage(state) {
    return SingleChildScrollView(
        child: Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: MainColors.PRIMARY,
      ),
      child: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 250.0),
            child: Center(
              child: Icon(
                Icons.score,
                color: MainColors.SECONDARY,
                size: 40.0,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Football",
                  style: TextStyle(
                    color: MainColors.TEXT_NEGATIVE,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  "System",
                  style: TextStyle(
                      color: MainColors.TEXT_NEGATIVE,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 150.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: MainColors.SECONDARY,
                    onPressed: () => gotoLogin(),
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
                              I18n().login,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: MainColors.PRIMARY,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget loginPage(state) {
    return SingleChildScrollView(
        child: Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: MainColors.SECONDARY,
      ),
      child: new Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: new Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(120.0),
              child: Center(
                child: Icon(
                  Icons.score,
                  color: MainColors.PRIMARY,
                  size: 50.0,
                ),
              ),
            ),
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: new Text(
                      I18n().email,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: MainColors.PRIMARY,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: MainColors.PRIMARY,
                      width: 0.5,
                      style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Expanded(
                    child: new StyledFormField(
                        type: 'email',
                        hint: 'email@example.com',
                        toValidate: true,
                        controller: _usernameController),
                  ),
                ],
              ),
            ),
            Divider(height: 24.0, color: Color.fromRGBO(255, 255, 255, 0)),
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: new Text(
                      I18n().password,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: MainColors.PRIMARY,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: MainColors.PRIMARY,
                      width: 0.5,
                      style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Expanded(
                    child: new StyledFormField(
                        hint: '*********',
                        hideText: true,
                        toValidate: true,
                        controller: _passwordController),
                  ),
                ],
              ),
            ),
            Divider(height: 24.0, color: Color.fromRGBO(255, 255, 255, 0)),
            new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: new FlatButton(
                    child: new Text(
                      I18n().forgotPassword,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: MainColors.PRIMARY,
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    onPressed: () => gotoRecover(),
                  ),
                ),
              ],
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
              alignment: Alignment.center,
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: new FlatButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      color: MainColors.PRIMARY,
                      onPressed:
                          state is! LoginLoading ? _onLoginButtonPressed : null,
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
                                I18n().login,
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
                ],
              ),
            ),
            new Container(
              child: state is LoginLoading ? LoadingIndicator() : null,
            ),
          ],
        ),
      ),
    ));
  }

  Widget recoverPassword(state) {
    return new Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: MainColors.SECONDARY,
      ),
      child: new Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: new Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(120.0),
              child: Center(
                child: Icon(
                  Icons.score,
                  color: MainColors.PRIMARY,
                  size: 50.0,
                ),
              ),
            ),
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: new Text(
                      I18n().email,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: MainColors.PRIMARY,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: MainColors.PRIMARY,
                      width: 0.5,
                      style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Expanded(
                    child: new StyledFormField(
                        type: 'email',
                        hint: 'email@example.com',
                        toValidate: true,
                        controller: _usernameController),
                  ),
                ],
              ),
            ),
            Divider(height: 24.0, color: Color.fromRGBO(255, 255, 255, 0)),
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: new Text(
                      "NUOVA PASSWORD",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: MainColors.PRIMARY,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: MainColors.PRIMARY,
                      width: 0.5,
                      style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Expanded(
                    child: new StyledFormField(
                        hint: '*********',
                        hideText: true,
                        toValidate: true,
                        controller: _passwordController),
                  ),
                ],
              ),
            ),
            Divider(height: 24.0, color: Color.fromRGBO(255, 255, 255, 0)),
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: new Text(
                      I18n().ripetiPassword,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: MainColors.PRIMARY,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: MainColors.PRIMARY,
                      width: 0.5,
                      style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Expanded(
                    child: new StyledFormField(
                        hint: '*********',
                        hideText: true,
                        toValidate: true,
                        controller: _samePasswordController),
                  ),
                ],
              ),
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
              alignment: Alignment.center,
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: new FlatButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      color: MainColors.PRIMARY,
                      onPressed: state is! LoginLoading
                          ? _onForgotPasswordButtonPressed
                          : null,
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
                                I18n().salva,
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
                ],
              ),
            ),
            new Container(
              child: state is LoginLoading ? LoadingIndicator() : null,
            ),
          ],
        ),
      ),
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  _onLoginButtonPressed() {
    if (_formKey.currentState.validate()) {
      _loginBloc.add(LoginButtonPressed(
        username: _usernameController.text,
        password: _passwordController.text,
      ));

      _usernameController.text = "";
      _passwordController.text = "";
    }
  }

  _onForgotPasswordButtonPressed() {
    if (_formKey.currentState.validate()) {
      if (_passwordController.text == _samePasswordController.text) {
        _loginBloc.add(ForgotPasswordButtonPressed(
          username: _usernameController.text,
          password: _passwordController.text,
        ));
      } else {
        _onWidgetDidBuild(() {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(I18n().passwordDifferent),
              backgroundColor: MainColors.PRIMARY,
            ),
          );
        });
      }
    }
  }

  gotoLogin() {
    _controller.animateToPage(
      1,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  gotoRecover() {
    _controller.animateToPage(
      2,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        bloc: _loginBloc,
        builder: (
          BuildContext context,
          LoginState state,
        ) {
          if (state is LoginFailure) {
            _onWidgetDidBuild(() {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.error}'),
                  backgroundColor: MainColors.PRIMARY,
                ),
              );
            });
          }

          return Container(
              height: MediaQuery.of(context).size.height,
              child: PageView(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  homePage(state),
                  loginPage(state),
                  recoverPassword(state)
                ],
                scrollDirection: Axis.horizontal,
              ));
        });
  }
}
