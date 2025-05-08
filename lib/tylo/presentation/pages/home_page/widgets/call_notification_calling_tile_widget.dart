import 'package:flutter/material.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/constants/app_strings.dart';


class CallNotificationCallingTileWidget extends StatelessWidget {
  const CallNotificationCallingTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      data: AppStrings.calling,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: ColorManager.green,
      ),
    );
  }
}
