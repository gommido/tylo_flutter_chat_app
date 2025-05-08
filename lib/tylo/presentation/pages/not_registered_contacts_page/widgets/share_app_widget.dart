import 'package:flutter/material.dart';

import '../../../../core/components/custom_widgets/custom_circle_avatar.dart';
import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/components/custom_widgets/custom_padding.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/constants/app_strings.dart';
import '../../../../core/services/localization/localization.dart';

class ShareAppWidget extends StatelessWidget {
  const ShareAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomColumn(
      children: [
        CustomRow(
          children: [
            CustomCircleAvatar(
              radius: 25,
              backgroundColor: ColorManager.primaryColor.withOpacity(0.2),
              child: CustomIcon(
                  icon: Icons.share,
                  color: ColorManager.primaryColor
              ),
            ),
            CustomSizedBox(width: size.width / 50,),
            CustomText(
              data: translate(context, AppStrings.shareTylo),
              style: Theme.of(context).textTheme.bodyLarge!,
            ),
          ],
        ),
        CustomPadding(
          padding: const EdgeInsets.only(left: 50),
          child: Divider(color: ColorManager.white.withOpacity(0.1),
          ),
        ),

      ],
    );
  }
}
