import 'package:flutter/material.dart';
import '../../../../core/components/custom_add_or_remove_contacts_from_group_widget.dart';


class RemoveContactFromGroupWidget extends StatelessWidget {
  const RemoveContactFromGroupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomAddOrRemoveContactsFromGroupWidget(
      isContain: true,
      isAdding: false,
    );
  }
}
