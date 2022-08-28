import 'package:flutter/material.dart';

class UiHelper {
  // ignore: constant_identifier_names
  static const NotImplementedScreen = Scaffold(
    body: Center(
      child: Text("Aguarde! Tela não implementada ainda ;)"),
    ),
  );

  static navigateTo(context, route) => Navigator.pushNamed(context, route);

  static errorPresenter(String errorMessage) =>
      Center(child: Text(errorMessage));

  static emptySpace(
    double space, {
    VerticalDirection direction = VerticalDirection.down,
  }) =>
      SizedBox(
        height: direction == VerticalDirection.down ? space : null,
        width: direction == VerticalDirection.up ? space : null,
      );
}
