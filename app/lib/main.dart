import 'package:flutter/material.dart';
import 'package:nucleus_agenda/core/shared/routes.dart';
import 'package:nucleus_agenda/view/screens/contact_list_screen.dart';
import 'package:nucleus_agenda/view/shared/strings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.APP_NAME,
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: ROUTES,
    );
  }
}
