import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_system/blocs/stuff/index.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:shared/shared.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'index.dart';

class OTPPage extends StatefulWidget {
  OTPPage({Key key, @required this.loginBloc}) : super(key: key);

  final LoginBloc loginBloc;

  @override
  _OTPPageState createState() => new _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  String signature = "{{ app signature }}";

  String _code;
  final _phoneFieldController = TextEditingController();

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    _sms();
    super.initState();
  }

  LoginBloc get _loginBloc => widget.loginBloc;

  _sms() async {
    await SmsAutoFill().getAppSignature;
    await SmsAutoFill().listenForCode;
    SmsAutoFill().code.listen((code) {
      setState(() {
        _code = code;
      });
    });
  }

  _onOtpButtonPressed() {
    String otp = _code;
    _loginBloc.add(OtpButtonPressed(otp: otp));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        bloc: _loginBloc,
        builder: (
          BuildContext context,
          LoginState state,
        ) {
          return MaterialApp(
            theme: ThemeData(
                cursorColor: MainColors.PRIMARY,
                primaryColor: MainColors.PRIMARY),
            home: Scaffold(
              appBar: AppBar(
                title: const Text('OTP'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Spacer(),
                    PhoneFieldHint(
                      autofocus: true,
                      controller: _phoneFieldController,
                    ),
                    Divider(
                        height: 24.0, color: Color.fromRGBO(255, 255, 255, 0)),
                    FlatButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      color: MainColors.PRIMARY,
                      onPressed: state is! LoginLoading
                          ? () => {
                                if (_phoneFieldController.text != null &&
                                    _phoneFieldController.text != '')
                                  {
                                    _loginBloc.add(OtpPageLoaded(
                                        mobileNumber:
                                            _phoneFieldController.text))
                                  }
                              }
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
                                "Richiedi codice",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: MainColors.SECONDARY,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    PinFieldAutoFill(
                      decoration: UnderlineDecoration(
                          color: MainColors.PRIMARY,
                          textStyle:
                              TextStyle(fontSize: 20, color: MainColors.TEXT)),
                      codeLength: 6,
                      currentCode: _code,
                    ),
                    Divider(
                        height: 24.0, color: Color.fromRGBO(255, 255, 255, 0)),

                    FlatButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      color: MainColors.PRIMARY,
                      onPressed:
                          state is! LoginLoading ? _onOtpButtonPressed : null,
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
                                "Conferma",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: MainColors.SECONDARY,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    new Container(
                      child: state is LoginLoading ? LoadingIndicator() : null,
                    ),
                    Spacer(),
                    // SizedBox(height: 8.0),
                    // Divider(height: 1.0),
                    // SizedBox(height: 4.0),
                    // Text("App Signature : $signature"),
                    // SizedBox(height: 4.0),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
