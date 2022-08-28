import 'package:flutter_contacts/contact.dart';

abstract class IContactService {
  Future<List<Contact>> list();
  Future<Contact> getById(String id);
  Future<Contact> create(Contact contact);
  Future<Contact> update(Contact contact);
  Future<void> remove(Contact contact);
}
