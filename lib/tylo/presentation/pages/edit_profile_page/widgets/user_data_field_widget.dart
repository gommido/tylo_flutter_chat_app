import 'package:flutter/material.dart';

import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/helper_functions/capitalize_all_words.dart';
import '../../../../core/helper_functions/detect_language.dart';


class UserDataFieldWidget extends StatelessWidget {
  const UserDataFieldWidget({super.key, required this.fieldName, required this.fieldValue, required this.icon});
  final String fieldName;
  final String fieldValue;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return CustomRow(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomRow(
          children: [
            CustomIcon(icon: icon),
            CustomText(
              data: fieldName,
              style: Theme.of(context).textTheme.bodySmall!,),
          ],
        ),
        CustomRow(
          children: [
            CustomBuilder(
              builder: (context) {
                final isLatinWord = detectWordLanguage(fieldValue);
                return CustomText(
                  data: isLatinWord ? capitalizeAllWords(fieldValue) : fieldName,
                  style: Theme.of(context).textTheme.bodySmall!,);
              }
            ),
            CustomIcon(icon: Icons.arrow_forward_ios),
          ],
        ),
      ],
    );
  }
}
