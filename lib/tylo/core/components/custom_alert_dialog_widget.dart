import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';
import '../helper_functions/navigator/navigator_pop.dart';
import '../resources/color_manager.dart';
import 'custom_widgets/custom_sized_box.dart';
import 'custom_widgets/custom_text.dart';
import 'custom_widgets/custom_text_button.dart';

class CustomAlertDialogWidget extends StatelessWidget {
  const CustomAlertDialogWidget({super.key, required this.title, required this.onPressed});
  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      backgroundColor: ColorManager.backgroundColor,
      title: CustomText(
        data: title,
        style: Theme.of(context).textTheme.bodySmall!,
      ),
      actions: [
        CustomTextButton(
          onPressed: onPressed,
          child: CustomText(
            data: translate(context, AppStrings.yes),
            style: Theme.of(context).textTheme.bodySmall!,
          ),
        ),
        CustomSizedBox(width: size.width / 20,),
        CustomTextButton(
          onPressed: (){
            navigateAndPop(context);
          },
          child: CustomText(
            data: translate(context, AppStrings.no),
            style: Theme.of(context).textTheme.bodySmall!,
          ),
        ),
      ],
    );
  }
}
