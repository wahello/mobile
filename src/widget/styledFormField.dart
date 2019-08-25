import 'package:flutter/material.dart';

/// Generica implementazione di una text box
class StyledFormField extends StatelessWidget {
  ///Suggerimento da inserire nella textbox
  final String hint;

  ///Testo nascosto
  final bool hideText;

  ///Validazione del testo
  final bool toValidate;
  final double width;
  final double height;
  final double horizontalPadding;
  final double verticalPadding;
  final String text;
  final TextEditingController controller;

  StyledFormField(
      {hint,
      hideText,
      this.height,
      this.width,
      verticalPadding,
      horizontalPadding,
      toValidate,
      text,
      this.controller})
      : horizontalPadding = horizontalPadding ?? 0,
        verticalPadding = verticalPadding ?? 0,
        hideText = hideText ?? false,
        toValidate = toValidate ?? false,
        text = text ?? null,
        hint = hint ?? '';

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        padding: new EdgeInsets.symmetric(
            vertical: verticalPadding, horizontal: horizontalPadding),
        child: new TextFormField(
          textAlign: TextAlign.left,
          controller: controller,
          initialValue: text,
          obscureText: hideText,
          validator: (value) {
            if (value.isEmpty && toValidate) {
              return 'Il campo non può essere vuoto';
            }
          },
          decoration: new InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ));
  }
}
