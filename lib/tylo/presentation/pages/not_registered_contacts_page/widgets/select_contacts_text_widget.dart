import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';

import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';

class SelectContactsTextWidget extends StatelessWidget {
  const SelectContactsTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomContainer(
      alignment: Alignment.center,
      width: size.width,
      height: size.height / 25,
      decoration: BoxDecoration(
        color: ColorManager.primaryColor.withOpacity(0.5),
      ),
      child: CustomText(
        data: translate(context, AppStrings.selectContactToInvite),
        style: Theme.of(context).textTheme.bodySmall!,
      ),
    );
  }
}
