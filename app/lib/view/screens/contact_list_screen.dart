import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:nucleus_agenda/infrastructure/routes.dart';
import 'package:nucleus_agenda/infrastructure/locator.dart';
import 'package:nucleus_agenda/view/components/contact_item_component.dart';
import 'package:nucleus_agenda/view/components/loading_component.dart';
import 'package:nucleus_agenda/view/controllers/contacts_controller.dart';
import 'package:nucleus_agenda/view/providers/contact_notifier.dart';
import 'package:nucleus_agenda/view/shared/strings.dart';
import 'package:nucleus_agenda/view/shared/ui_helper.dart';
import 'package:provider/provider.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({Key? key}) : super(key: key);

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final _controller = locator<ContactController>();
  late Future<List<Contact>> _future;

  ContactNotifier? _notifier;

  @override
  void initState() {
    super.initState();
    _future = _controller.list();
  }

  @override
  Widget build(BuildContext context) {
    _notifier ??= Provider.of<ContactNotifier>(context);

    if (_notifier!.reload) {
      _future = _controller.list();
      _notifier!.setReload(false);
    }

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  _buildBody() => FutureBuilder(
      future: _future,
      builder: (_, AsyncSnapshot<List<Contact>?> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const LoadingComponent();
          case ConnectionState.none:
            return UiHelper.errorPresenter(Strings.couldntLoadContacts);
          default:
            var contacts = snapshot.data;

            return contacts != null
                ? _buildContactList(context, contacts)
                : UiHelper.errorPresenter(Strings.noContacts);
        }
      });

  _buildAppBar() => AppBar(
        title: const Text(Strings.APP_NAME, textAlign: TextAlign.center),
      );

  _buildFloatingActionButton() => FloatingActionButton(
      child: const Center(child: Icon(Icons.person_add)),
      onPressed: () {
        _notifier!.setContact(null);
        UiHelper.navigateTo(context, RouteNames.createContact);
      });

  _buildContactList(BuildContext context, List<Contact> contacts) =>
      ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (_, int index) {
            return ContactItemComponent(contact: contacts[index]);
          });
}
