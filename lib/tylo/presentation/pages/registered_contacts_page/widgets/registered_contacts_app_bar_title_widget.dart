import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/services/localization/localization.dart';

class RegisteredContactsAppBarTitleWidget extends StatelessWidget {
  const RegisteredContactsAppBarTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      data: translate(context, AppStrings.contacts),
      style: Theme.of(context).textTheme.bodyMedium!,
    );
  }
}
