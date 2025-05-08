import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/services/localization/localization.dart';

class CreateAccountTitleWidget extends StatelessWidget {
  const CreateAccountTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomColumn(
      children: [
        CustomText(
          data: translate(context, AppStrings.createAccount),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: ColorManager.white,
            fontSize: FontManager.s30,
          ),
        ),
        CustomSizedBox(height: size.height / 100,),
        CustomText(
          data: translate(context, AppStrings.getStarted),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: ColorManager.white.withOpacity(0.8),
            fontSize: FontManager.s20,
          ),
        ),
      ],
    );
  }
}
