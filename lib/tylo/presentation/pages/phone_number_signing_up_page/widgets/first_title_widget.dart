import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/services/localization/localization.dart';

class FirstTitleWidget extends StatelessWidget {
  const FirstTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      data: translate(context, AppStrings.addPhoneNumber),
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        color: ColorManager.white,
        fontSize: FontManager.s20,
      ),
    );
  }
}
