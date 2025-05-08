import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/helper_functions/navigator/push_named_navigator.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/constants/app_routes.dart';
import '../../../../core/services/localization/localization.dart';

class PrivacyTitleWidget extends StatelessWidget {
  const PrivacyTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomGestureDetector(
      onTap: (){
        pushNamed(route: AppRoutes.privacyPage, context: context);
      },
      child: CustomContainer(
        decoration: const BoxDecoration(
            color: Colors.transparent
        ),
        child: CustomRow(
          children: [
            CustomIcon(
              icon: Icons.lock_open,
              color: ColorManager.grey,
            ),
            CustomSizedBox(width: size.width / 50,),
            CustomText(
              data: translate(context, AppStrings.privacy),
              style: Theme.of(context).textTheme.bodyMedium!,
            ),
          ],
        ),
      ),
    );
  }
}
