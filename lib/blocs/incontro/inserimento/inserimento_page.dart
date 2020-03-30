import 'package:flutter/material.dart';
import 'package:football_system/blocs/incontro/inserimento/index.dart';
import 'package:football_system/generated/i18n.dart';

class InserimentoPage extends StatefulWidget {
  final Function(Widget) notifyParent;
  final Function(Widget) notifyAction;
  final Key key;

  InserimentoPage({
    this.notifyAction,
    this.key,
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
  Widget build(BuildContext context) {
    widget.notifyParent(Text(I18n().inserimentoIncontro));
    return InserimentoScreen(
        notifyParent: widget.notifyParent, notifyAction: widget.notifyAction);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
