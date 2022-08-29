import 'package:flutter_contacts/contact.dart';
import 'package:nucleus_agenda/infrastructure/locator.dart';
import 'package:nucleus_agenda/services/classes/contact_service.dart';

class ContactController {
  final _contactService = locator<ContactService>();

  Future<List<Contact>> list() async => await _contactService.list();

  Future<Contact> update(Contact contact) async =>
      await _contactService.update(contact);

  Future<void> delete(Contact contact) async =>
      await _contactService.remove(contact);

  Future<Contact> create(Contact contact) async =>
      await _contactService.create(contact);
}
