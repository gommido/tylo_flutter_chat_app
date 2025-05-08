import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';

import '../../../../core/components/custom_widgets/custom_text.dart';

class AccountSettingsTitleWidget extends StatelessWidget {
  const AccountSettingsTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      data: translate(context, AppStrings.accountSettings),
      style: Theme.of(context).textTheme.bodyLarge!,
    );
  }
}
