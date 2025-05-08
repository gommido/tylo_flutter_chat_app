import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../../../../core/components/custom_widgets/custom_center.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';

class EmptyContactsWidget extends StatelessWidget {
  const EmptyContactsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCenter(
      child: CustomText(
        data: AppStrings.noRegisteredContacts,
        style: Theme.of(context).textTheme.bodySmall!,
      ),
    );
  }
}
