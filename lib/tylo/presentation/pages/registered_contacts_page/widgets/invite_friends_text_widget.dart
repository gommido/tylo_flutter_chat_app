import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';

import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';

class InviteFriendsTextWidget extends StatelessWidget {
  const InviteFriendsTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          data: translate(context, AppStrings.startInviteFriends),
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: ColorManager.white.withOpacity(0.7),
          ),
        ),
        CustomSizedBox(height: size.height / 50,),
        CustomText(
          data: translate(context, AppStrings.shareLink),
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: ColorManager.white.withOpacity(0.7),
          ),
        ),
        CustomText(
          data: translate(context, AppStrings.familyAndColleagues),
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: ColorManager.white.withOpacity(0.7),

          ),
        ),

      ],
    );
  }
}
