import 'package:flutter/material.dart';

import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/constants/app_strings.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/services/localization/localization.dart';

class OngoingCallTitleWidget extends StatelessWidget {
  const OngoingCallTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      data: translate(context, AppStrings.ongoingCall),
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        color: ColorManager.green,
        fontSize: FontManager.s24,
      ),
    );
  }
}
