import 'package:flutter/material.dart';
import 'package:nucleus_agenda/view/screens/contact_list_screen.dart';
import 'package:nucleus_agenda/view/screens/create_contact_screen.dart';

class RouteNames {
  static const listContacts = '/';
  static const createContact = '/create';
}

// ignore: non_constant_identifier_names
Map<String, Widget Function(BuildContext)> ROUTES = {
  RouteNames.listContacts: (context) => const ContactListScreen(),
  RouteNames.createContact: (context) => const CreateContactScreen(),
};
