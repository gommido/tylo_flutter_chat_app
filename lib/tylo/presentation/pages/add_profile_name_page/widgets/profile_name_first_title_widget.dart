import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/services/localization/localization.dart';

class ProfileNameFirstTitleWidget extends StatelessWidget {
  const ProfileNameFirstTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      data: translate(context, AppStrings.profileName),
      style: Theme.of(context).textTheme.bodyLarge!,
    );
  }
}
