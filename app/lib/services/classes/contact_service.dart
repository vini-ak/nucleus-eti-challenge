import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:nucleus_agenda/core/exceptions/service_exception.dart';
import 'package:nucleus_agenda/core/shared/error_messages.dart';
import 'package:nucleus_agenda/services/interfaces/icontact_service.dart';

class ContactService implements IContactService {
  @override
  Future<Contact> create(contact) async => await contact.insert();

  @override
  Future<List<Contact>> list() async {
    var requestPermission = await _hasContactPermission();

    if (!requestPermission) {
      throw ServiceException(ErrorMessages.contactServiceNotAllowed);
    }

    var contacts = await FlutterContacts.getContacts(
        withPhoto: true,
        withAccounts: true,
        withProperties: true,
        withGroups: true);

    return contacts;
  }

  @override
  Future<Contact> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<void> remove(Contact contact) async => await contact.delete();

  @override
  Future<Contact> update(Contact contact) async => await contact.update();

  Future<bool> _hasContactPermission() async {
    var requestPermission = await FlutterContacts.requestPermission();
    return requestPermission;
  }
}
