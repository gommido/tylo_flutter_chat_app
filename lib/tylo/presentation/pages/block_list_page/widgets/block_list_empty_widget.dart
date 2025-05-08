import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';

import '../../../../core/components/custom_widgets/custom_center.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';

class BlockListEmptyWidget extends StatelessWidget {
  const BlockListEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCenter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIcon(
            icon: Icons.checklist_rtl,
            color: ColorManager.white.withOpacity(0.5),
          ),
          CustomText(
            data: translate(context, AppStrings.blockListEmpty),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: ColorManager.white.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
