import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';

class LanguageTitleWidget extends StatelessWidget {
  const LanguageTitleWidget({super.key, required this.language});
  final Map<String, dynamic> language;

  @override
  Widget build(BuildContext context) {
    return CustomColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          data: language[AppStrings.name],
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: ColorManager.white,
        ),
        ),
        CustomText(
          data: language[AppStrings.translation],
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: ColorManager.white.withOpacity(0.5),
        ),
        ),
      ],
    );
  }
}
