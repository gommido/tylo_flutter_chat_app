import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';

import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';

class WhoCanSeeLastSeenAndOnlineStatusWidget extends StatelessWidget {
  const WhoCanSeeLastSeenAndOnlineStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      data: translate(context, AppStrings.whoCanSeeMyLastSeen),
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: ColorManager.grey,
      ),
    );
  }
}
