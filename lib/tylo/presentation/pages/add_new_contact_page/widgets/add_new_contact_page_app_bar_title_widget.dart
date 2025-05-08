import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';

import '../../../../core/components/custom_widgets/custom_text.dart';

class AddNewContactPageAppBarTitleWidget extends StatelessWidget {
  const AddNewContactPageAppBarTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      data: translate(context, AppStrings.newContact),
      style: Theme.of(context).textTheme.bodyLarge!,
    );
  }
}
