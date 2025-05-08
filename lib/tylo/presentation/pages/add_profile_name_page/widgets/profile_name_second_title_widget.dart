import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/services/localization/localization.dart';

class ProfileNameSecondTitleWidget extends StatelessWidget {
  const ProfileNameSecondTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      data: translate(context, AppStrings.nameVisible),
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        color: ColorManager.grey,
      ),
    );
  }
}
