import 'package:flutter/material.dart';
import 'package:nucleus_agenda/infrastructure/providers.dart';
import 'package:nucleus_agenda/infrastructure/routes.dart';
import 'package:nucleus_agenda/infrastructure/locator.dart';
import 'package:nucleus_agenda/view/shared/strings.dart';
import 'package:provider/provider.dart';

void main() {
  // Criando locator...
  setupLocator();

  // Renderizando a aplicação...
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: Strings.APP_NAME,
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        routes: ROUTES,
      ),
    );
  }
}
