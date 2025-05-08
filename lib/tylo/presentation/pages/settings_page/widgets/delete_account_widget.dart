import 'package:flutter/material.dart';

import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/constants/app_strings.dart';
import '../../../../core/services/localization/localization.dart';

class DeleteAccountWidget extends StatelessWidget {
  const DeleteAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomGestureDetector(
      onTap: (){

      },
      child: CustomContainer(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: ColorManager.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: CustomRow(
          children: [
            CustomIcon(
              icon: Icons.no_accounts_outlined,
              color: ColorManager.grey,
            ),
            CustomSizedBox(width: size.width / 50,),
            CustomText(
              data: translate(context, AppStrings.deleteAccount),
              style: Theme.of(context).textTheme.bodyMedium!,
            ),
          ],
        ),
      ),
    );
  }
}
