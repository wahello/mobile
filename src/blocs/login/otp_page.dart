import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../const/colors.dart';
import 'index.dart';

class OTPPage extends StatefulWidget {
  final LoginBloc loginBloc;

  OTPPage({Key key, @required this.loginBloc}) : super(key: key);

  @override
  _OTPPageState createState() => new _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  String _code;
  String signature = "{{ app signature }}";
  LoginBloc get _loginBloc => widget.loginBloc;
  final _phoneFieldController = TextEditingController();

  @override
  void initState() {
    _phoneFieldController.addListener(() {
      if (_phoneFieldController.text != null &&
          _phoneFieldController.text != '') {
        _loginBloc
            .dispatch(OtpPageLoaded(mobileNumber: _phoneFieldController.text));
      }
    });
    _sms();
    super.initState();
  }

  _sms() async {
    await SmsAutoFill().getAppSignature;
    await SmsAutoFill().listenForCode;
    SmsAutoFill().code.listen((code) {
      setState(() {
        _code = code;
      });
    });
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          cursorColor: MainColors.PRIMARY, primaryColor: MainColors.PRIMARY),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('OTP'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              PhoneFieldHint(
                autofocus: true,
                controller: _phoneFieldController,
              ),
              Spacer(),
              PinFieldAutoFill(
                decoration: UnderlineDecoration(
                    color: MainColors.PRIMARY,
                    textStyle: TextStyle(fontSize: 20, color: MainColors.TEXT)),
                codeLength: 6,
                currentCode: _code,
              ),
              Spacer(),
              new FlatButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                color: MainColors.PRIMARY,
                onPressed: _onOtpButtonPressed,
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
  }

  _onOtpButtonPressed() {
    String otp = _code;
    _loginBloc.dispatch(OtpButtonPressed(otp: otp));
  }
}
