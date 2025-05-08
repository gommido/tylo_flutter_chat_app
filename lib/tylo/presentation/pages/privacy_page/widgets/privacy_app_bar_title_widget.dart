import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';

import '../../../../core/components/custom_widgets/custom_text.dart';

class PrivacyAppBarTitleWidget extends StatelessWidget {
  const PrivacyAppBarTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      data: translate(context, AppStrings.privacy),
      style: Theme.of(context).textTheme.bodyMedium!,
    );
  }
}
