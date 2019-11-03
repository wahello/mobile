import 'package:flutter/material.dart';
import 'package:football_system/blocs/incontro/inserimento/index.dart';
import 'package:football_system/generated/i18n.dart';

class InserimentoPage extends StatefulWidget {
  final Function(String) notifyParent;

  InserimentoPage({
    Key key,
    this.notifyParent,
  }) : super(key: key);

  @override
  State<InserimentoPage> createState() => _InserimentoPageState();
}

class _InserimentoPageState extends State<InserimentoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    widget.notifyParent(I18n().inserimentoIncontro);
    return InserimentoScreen();
  }

  @override
  void dispose() {
    super.dispose();
  }
}