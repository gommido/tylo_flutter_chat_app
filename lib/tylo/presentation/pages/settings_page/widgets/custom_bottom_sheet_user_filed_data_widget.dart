import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';
import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/components/custom_widgets/custom_text_button.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import 'bottom_sheet_cancel_button_widget.dart';

class CustomBottomSheetUserFieldWidget extends StatelessWidget {
  const CustomBottomSheetUserFieldWidget({super.key, required this.filedName, required this.firstDescription, required this.finalDescription, required this.textField, required this.onPressed});
  final String filedName;
  final Widget textField;
  final String firstDescription;
  final String finalDescription;
  final VoidCallback onPressed;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomColumn(
      children: [
        CustomRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const BottomSheetCancelButtonWidget(),
            CustomText(
              data: filedName,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: FontManager.s16,
              ),
            ),
            CustomTextButton(
              onPressed: onPressed,
              child: CustomText(
                data: translate(context, AppStrings.save),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: FontManager.s16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        CustomSizedBox(height: size.height / 100,),
        CustomText(
          data: firstDescription,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        CustomSizedBox(height: size.height / 100,),
        CustomContainer(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          width: size.width,
          height: size.height / 10,
          decoration: BoxDecoration(
              color: ColorManager.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: ColorManager.white.withOpacity(0.3))
          ),
          child: textField,
        ),
        CustomSizedBox(height: size.height / 100,),
        CustomText(
            data: finalDescription,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: ColorManager.grey,
            ),
        ),
      ],
    );

  }
}
