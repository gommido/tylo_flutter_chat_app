import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/services/localization/localization.dart';

class AppSettingsTitle extends StatelessWidget {
  const AppSettingsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      data: translate(context, AppStrings.appSettings),
      style: Theme.of(context).textTheme.bodyLarge!,
    );
  }
}
