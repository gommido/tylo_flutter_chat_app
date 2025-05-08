import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_routes.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';

import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/helper_functions/navigator/push_named_navigator.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/constants/app_strings.dart';

class InviteTextWidget extends StatelessWidget {
  const InviteTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomGestureDetector(
      onTap: (){
        pushNamed(route: AppRoutes.notRegisteredContactsPage, context: context);
      },
      child: CustomContainer(
        alignment: Alignment.center,
        width: size.width / 5,
        height: size.width / 10,
        decoration: BoxDecoration(
            color: ColorManager.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20.0)
        ),
        child: CustomText(
          data: translate(context, AppStrings.invite),
          style: Theme.of(context).textTheme.bodyMedium!,
        ),
      ),
    );
  }
}
