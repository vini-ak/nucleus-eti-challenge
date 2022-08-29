import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';

class ContactNotifier extends ChangeNotifier {
  // Propriedades
  Contact? _selectedContact;
  bool _reload = false;

  // Getters
  Contact? get selectedContact => _selectedContact;
  bool get reload => _reload;

  // Setters
  void setContact(Contact? contact, {notify = true}) {
    _selectedContact = contact;
    if (notify) notifyListeners();
  }

  void setReload(bool value, {notify = false}) {
    _reload = value;

    if (notify) {
      notifyListeners();
    }
  }
}
