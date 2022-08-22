import 'package:flutter/material.dart';

class UiHelper {
  // ignore: constant_identifier_names
  static const NotImplementedScreen = Scaffold(
    body: Center(
      child: Text("Aguarde! Tela não implementada ainda ;)"),
    ),
  );

  static navigateTo(context, route) => Navigator.pushNamed(context, route);
}
