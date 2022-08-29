import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:nucleus_agenda/infrastructure/routes.dart';
import 'package:nucleus_agenda/view/providers/contact_notifier.dart';
import 'package:nucleus_agenda/view/shared/constants.dart';
import 'package:nucleus_agenda/view/shared/ui_helper.dart';
import 'package:provider/provider.dart';

class ContactItemComponent extends StatefulWidget {
  final Contact contact;
  const ContactItemComponent({Key? key, required this.contact})
      : super(key: key);

  @override
  State<ContactItemComponent> createState() => _ContactItemComponentState();
}

class _ContactItemComponentState extends State<ContactItemComponent> {
  late Contact _contact;

  ContactNotifier? _notifier;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contact = widget.contact;
  }

  @override
  Widget build(BuildContext context) {
    _notifier = Provider.of<ContactNotifier>(context);

    return ListTile(
      title: _buildBody(),
      onTap: () {
        _notifier!.setContact(_contact);
        UiHelper.navigateTo(context, RouteNames.createContact);
      },
    );
  }

  _buildBody() => Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          _contact.photo != null
              ? _buildContactImage(_contact.photo!)
              : _buildNoPhoto(),
          UiHelper.emptySpace(Spaces.small, direction: VerticalDirection.up),
          Flexible(
            child: Text(
              _contact.displayName,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      );

  _buildContactImage(Uint8List photoInBytes) => CircleAvatar(
        radius: Spaces.medium,
        backgroundImage: MemoryImage(photoInBytes),
      );

  _buildNoPhoto() => const CircleAvatar(
        radius: Spaces.medium,
        backgroundColor: Colors.grey,
      );
}
