import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/properties/address.dart';
import 'package:flutter_contacts/properties/email.dart';
import 'package:flutter_contacts/properties/phone.dart';
import 'package:nucleus_agenda/infrastructure/locator.dart';
import 'package:nucleus_agenda/view/components/dialogs/delete_contact_dialog.dart';
import 'package:nucleus_agenda/view/components/input_component.dart';
import 'package:nucleus_agenda/view/controllers/contacts_controller.dart';
import 'package:nucleus_agenda/view/providers/contact_notifier.dart';
import 'package:nucleus_agenda/view/shared/constants.dart';
import 'package:nucleus_agenda/view/shared/strings.dart';
import 'package:nucleus_agenda/view/shared/ui_helper.dart';
import 'package:nucleus_agenda/view/shared/utils.dart';
import 'package:provider/provider.dart';

class CreateContactScreen extends StatefulWidget {
  const CreateContactScreen({Key? key}) : super(key: key);

  @override
  State<CreateContactScreen> createState() => _CreateContactScreenState();
}

class _CreateContactScreenState extends State<CreateContactScreen> {
  final _controller = locator<ContactController>();

  ContactNotifier? _notifier;

  @override
  Widget build(BuildContext context) {
    // Criando instância do provider se ela for nula.
    _notifier ??= Provider.of<ContactNotifier>(context);

    var selectedContact = _notifier!.selectedContact ?? Contact();

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(selectedContact),
    );
  }

  _buildBody(Contact contact) => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
            vertical: Spaces.large, horizontal: Spaces.small),
        child: Column(children: [
          //
          InputComponent(
            label: "Nome",
            onChange: (value) {
              var names = Utils.splitContactName(value);

              // Definindo o primeiro
              contact.name.first = names.first;
              // Definindo o segundo
              contact.name.last = names.length < 2 ? '' : names[1];
            },
            initialValue:
                contact.displayName.isNotEmpty ? contact.displayName : null,
          ),
          UiHelper.emptySpace(Spaces.small),

          // Telefone 1
          InputComponent(
            label: "Telefone",
            onChange: (value) {
              if (contact.phones.isNotEmpty) {
                contact.phones.first.number = value;
              } else {
                Phone phone = Phone(value);
                contact.phones.add(phone);
              }
            },
            inputType: TextInputType.phone,
            initialValue:
                contact.phones.isNotEmpty ? contact.phones.first.number : null,
          ),
          UiHelper.emptySpace(Spaces.small),

          // Telefone 2
          InputComponent(
            label: "Telefone Secundário",
            onChange: (value) {
              if (contact.phones.length > 1) {
                contact.phones[1].number = value;
              } else {
                Phone phone = Phone(value);
                contact.phones.add(phone);
              }
            },
            inputType: TextInputType.phone,
            initialValue:
                contact.phones.length > 1 ? contact.phones[1].number : null,
          ),
          UiHelper.emptySpace(Spaces.small),

          // Email
          InputComponent(
            label: "Email",
            onChange: (value) {
              if (contact.emails.isNotEmpty) {
                contact.emails.first.address = value;
              } else {
                Email email = Email(value);
                contact.emails.add(email);
              }
            },
            inputType: TextInputType.emailAddress,
            initialValue:
                contact.emails.isNotEmpty ? contact.emails.first.address : null,
          ),
          UiHelper.emptySpace(Spaces.small),

          // Endereço
          InputComponent(
            label: "Endereço",
            onChange: (value) {
              if (contact.addresses.isNotEmpty) {
                contact.addresses.first.address = value;
              } else {
                Address address = Address(value);
                contact.addresses.add(address);
              }
            },
            inputType: TextInputType.streetAddress,
            initialValue: contact.addresses.isNotEmpty
                ? contact.addresses.first.address
                : null,
          ),
          UiHelper.emptySpace(Spaces.small),

          // Lembrete
          InputComponent(
            label: "Lembrete",
            onChange: (value) {},
            inputType: TextInputType.datetime,
          ),
          UiHelper.emptySpace(Spaces.medium),

          // Botões de ação
          _buildActionButtons(contact),
        ]),
      );

  _buildAppBar() => AppBar(
        title: const Text(Strings.APP_NAME, textAlign: TextAlign.center),
        actions: _notifier!.selectedContact != null
            ? [
                IconButton(
                  onPressed: () {
                    deleteContactDialog(context, _notifier!.selectedContact!);
                  },
                  icon: const Icon(Icons.delete),
                )
              ]
            : null,
      );

  _buildActionButtons(Contact? contact) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            child: const Text("Cancelar"),
            onPressed: () {
              _notifier!.setContact(null, notify: false);
              Navigator.pop(context);
            },
          ),
          UiHelper.emptySpace(Spaces.small, direction: VerticalDirection.up),
          TextButton(
            child: const Text("Salvar"),
            onPressed: () async {
              if (_notifier!.selectedContact != null) {
                await _controller
                    .update(_notifier!.selectedContact!)
                    .then((value) {
                  _notifier!.setReload(true, notify: true);
                  Navigator.pop(context);
                });
              } else {
                await _controller.create(contact!).then((value) {
                  _notifier!.setReload(true, notify: true);
                  _notifier!.setContact(value);
                  Navigator.pop(context);

                  UiHelper.showSnackbar(context, "Contato criado com sucesso!");
                });
              }
            },
          ),
        ],
      );
}
