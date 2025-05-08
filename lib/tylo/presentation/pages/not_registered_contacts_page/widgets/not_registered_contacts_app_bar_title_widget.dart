import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/services/localization/localization.dart';

class NotRegisteredContactsAppBarTitleWidget extends StatelessWidget {
  const NotRegisteredContactsAppBarTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      data: translate(context, AppStrings.inviteFriends),
      style: Theme.of(context).textTheme.bodyMedium!,
    );
  }
}
