import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';

import '../resources/color_manager.dart';
import 'animated_dots.dart';
import 'custom_widgets/custom_row.dart';
import 'custom_widgets/custom_text.dart';

class TypingNowWidget extends StatelessWidget {
  const TypingNowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomRow(
      children: [
        CustomText(
          data: translate(context, AppStrings.typingNow),
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: ColorManager.green,
          ),
        ),
        const AnimatedDots(),
      ],
    );
  }
}
