import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/services/localization/localization.dart';
import '../../../../core/services/shared_preference/shared_prefs_manager.dart';

class PrivacyPolicyAndTermsWidget extends StatelessWidget {
  const PrivacyPolicyAndTermsWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomColumn(
      children: [
        CustomRow(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              data: translate(context, AppStrings.byContinuing),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: ColorManager.white,
                fontSize: FontManager.s10,
              ),
            ),
            CustomSizedBox(height: size.height / 100,),
            CustomText(
              data: SharedPrefsManager.getMapData(key: AppStrings.country)[AppStrings.name]!,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: ColorManager.primaryColor,
                fontSize: FontManager.s08,
              ),
            ),
          ],
        ),
        CustomSizedBox(height: size.height / 200,),
        CustomRow(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              data: translate(context, AppStrings.youAgree),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: ColorManager.white,
                fontSize: FontManager.s08,
              ),
            ),

            CustomText(
              data: translate(context, AppStrings.terms),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: ColorManager.primaryColor,
                fontSize: FontManager.s08,
              ),
            ),
            CustomText(
              data: translate(context, AppStrings.acknowledge),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: ColorManager.white,
                fontSize: FontManager.s08,
              ),
            ),
          ],
        ),
        CustomSizedBox(height: size.height / 200,),

        CustomRow(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              data: translate(context, AppStrings.youRead),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: ColorManager.white,
                fontSize: FontManager.s08,
              ),
            ),
            CustomText(
              data: translate(context, AppStrings.privacyPolicy),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: ColorManager.primaryColor,
                fontSize: FontManager.s08,
              ),
            ),
            CustomSizedBox(height: size.height / 25,),

          ],
        ),
      ],
    );
  }
}
