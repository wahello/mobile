import 'package:flutter/material.dart';

import 'fieldFraction.dart';

/*
  UNA RIGA DELLA SCACCHIERA
 */
class FieldRow extends StatelessWidget {
  final List<int> children;

  FieldRow({this.children});

  @override
  Widget build(BuildContext context) {
    print(children);
    return Row(
      children: children
          .map((singlePosition) => FieldFraction(
              occupied: singlePosition, actual_position: children))
          .toList(),
    );
  }
}
