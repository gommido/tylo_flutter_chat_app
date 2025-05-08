import 'package:flutter/material.dart';

import '../../../../core/components/custom_add_or_remove_contacts_from_group_widget.dart';

class AddContactToGroupWidget extends StatelessWidget {
  const AddContactToGroupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomAddOrRemoveContactsFromGroupWidget(
      isContain: false,
      isAdding: true,
    );
  }
}
