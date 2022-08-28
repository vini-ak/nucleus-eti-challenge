import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:nucleus_agenda/infrastructure/locator.dart';
import 'package:nucleus_agenda/view/controllers/contacts_controller.dart';
import 'package:nucleus_agenda/view/providers/contact_notifier.dart';
import 'package:nucleus_agenda/view/shared/constants.dart';
import 'package:nucleus_agenda/view/shared/ui_helper.dart';
import 'package:provider/provider.dart';

void deleteContactDialog(
  BuildContext context,
  Contact contact,
) {
  final notifier = Provider.of<ContactNotifier>(context, listen: false);
  final controller = locator<ContactController>();

  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Remover contato"),
          content: Text(
              "Você tem certeza de que deseja remover ${contact.displayName} da sua agenda?"),
          actions: [
            TextButton(
              child: const Text("Cancelar"),
              onPressed: () {
                notifier.setContact(null);
                Navigator.pop(context);
              },
            ),
            UiHelper.emptySpace(Spaces.small, direction: VerticalDirection.up),
            TextButton(
              child: const Text("Remover contato"),
              onPressed: () async {
                await controller.delete(contact).then((value) {
                  notifier.setContact(null);
                  notifier.setReload(true, notify: true);

                  // Fechando o modal e voltando para a tela de listagem.
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
              },
            ),
          ],
        );
      });
}
