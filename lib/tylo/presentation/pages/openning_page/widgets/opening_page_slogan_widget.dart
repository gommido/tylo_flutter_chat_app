import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import '../../../../core/components/custom_widgets/custom_center.dart';
import '../../../../core/components/custom_widgets/custom_positioned.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/services/localization/localization.dart';

class OpeningPageSloganWidget extends StatelessWidget {
  const OpeningPageSloganWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomPositioned(
      bottom: size.height / 6,
      right: 0,
      left: 0,
      child: CustomCenter(
        child: CustomText(
          data: translate(context, AppStrings.stayConnected),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: ColorManager.white,
              fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
