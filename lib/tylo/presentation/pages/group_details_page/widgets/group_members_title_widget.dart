import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/services/localization/localization.dart';

class GroupMembersTitleWidget extends StatelessWidget {
  const GroupMembersTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomRow(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomIcon(icon: Icons.group_add_outlined, ),
        CustomSizedBox(width: size.width / 50,),
        CustomColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              data: translate(context, AppStrings.membersWithCapital),
              style: Theme.of(context).textTheme.bodyMedium!,
            ),
          ],
        ),
      ],
    );
  }
}
