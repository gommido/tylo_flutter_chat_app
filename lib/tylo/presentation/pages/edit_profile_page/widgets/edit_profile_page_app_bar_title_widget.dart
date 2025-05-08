import 'package:flutter/material.dart';

import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/constants/app_strings.dart';
import '../../../../core/services/localization/localization.dart';

class EditProfilePageAppBarTitleWidget extends StatelessWidget {
  const EditProfilePageAppBarTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      data: translate(context, AppStrings.editProfile),
      style: Theme.of(context).textTheme.bodyMedium!,
    );
  }
}
