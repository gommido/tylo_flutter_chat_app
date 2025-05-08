import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/services/localization/localization.dart';

class PhoneVerificationTitleWidget extends StatelessWidget {
  const PhoneVerificationTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      data: translate(context, AppStrings.phoneVerification),
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        color: ColorManager.white,
      ),
    );
  }
}
