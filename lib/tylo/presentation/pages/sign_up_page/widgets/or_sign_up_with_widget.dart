import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';

import '../../../../core/components/custom_widgets/custom_divider.dart';
import '../../../../core/components/custom_widgets/custom_expanded.dart';
import '../../../../core/components/custom_widgets/custom_padding.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';

class OrSignUpWithWidget extends StatelessWidget {
  const OrSignUpWithWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomRow(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomExpanded(
            child: CustomDivider(
              color: ColorManager.white.withOpacity(0.5),
            ),
        ),
        CustomPadding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: CustomText(
            data: translate(context, 'orSignUpWith'),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: ColorManager.white,
            ),
          ),
        ),
        CustomExpanded(
            child: CustomDivider(
              color: ColorManager.white.withOpacity(0.5),
            ),
        ),

      ],
    );
  }
}
