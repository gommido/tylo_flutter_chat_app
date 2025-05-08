import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';

import '../../../../core/components/animated_dots.dart';
import '../../../../core/components/custom_widgets/custom_circle_avatar.dart';
import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';

class SendingTextWidget extends StatelessWidget {
  const SendingTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCircleAvatar(
      radius: 18,
      backgroundColor: ColorManager.black.withOpacity(0.5),
      child: CustomColumn(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            data: translate(context, AppStrings.sending),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: FontManager.s06
            ),
          ),
          const AnimatedDots(),
        ],
      ),
    );
  }
}
