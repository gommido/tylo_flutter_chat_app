import 'package:flutter/material.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/constants/app_strings.dart';
import '../../../../core/services/localization/localization.dart';

class LastMessageVideoCallTypeWidget extends StatelessWidget {
  const LastMessageVideoCallTypeWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      data: translate(context, AppStrings.videoFile),
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        color: ColorManager.grey,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
