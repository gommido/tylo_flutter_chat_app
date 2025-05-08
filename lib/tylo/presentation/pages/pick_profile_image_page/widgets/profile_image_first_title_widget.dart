import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/services/localization/localization.dart';

class ProfileImageFirstTitleWidget extends StatelessWidget {
  const ProfileImageFirstTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      data: translate(context, AppStrings.profilePhoto),
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        color: ColorManager.white,
      ),
    );
  }
}
