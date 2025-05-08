import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/components/custom_widgets/custom_text_button.dart';
import '../../../../core/helper_functions/navigator/navigator_pop.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/services/localization/localization.dart';

class BottomSheetCancelButtonWidget extends StatelessWidget {
  const BottomSheetCancelButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextButton(
      onPressed: (){
        navigateAndPop(context);
      },
      child: CustomText(
        data: translate(context, AppStrings.cancel),
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
          fontSize: FontManager.s16,
          color: ColorManager.red,
        ),
      ),
    );
  }
}
