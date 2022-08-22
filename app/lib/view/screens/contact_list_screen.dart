import 'package:flutter/material.dart';
import 'package:nucleus_agenda/core/shared/routes.dart';
import 'package:nucleus_agenda/view/shared/strings.dart';
import 'package:nucleus_agenda/view/shared/ui_helper.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({Key? key}) : super(key: key);

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  _buildBody() => Column();

  _buildAppBar() => AppBar(
        title: const Text(Strings.APP_NAME, textAlign: TextAlign.center),
      );

  _buildFloatingActionButton() => FloatingActionButton(
        child: const Center(child: Icon(Icons.person_add)),
        onPressed: () => UiHelper.navigateTo(context, RouteNames.createContact),
      );
}
