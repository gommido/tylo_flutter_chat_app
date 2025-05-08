import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';

import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/helper_functions/date_format.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';

class LastMessageTimeSentWidget extends StatelessWidget {
  const LastMessageTimeSentWidget({super.key, required this.sentTime});
  final Timestamp sentTime;

  @override
  Widget build(BuildContext context) {
    final day = formatChatTimesInDays(sentTime);

    switch(day){
      case AppStrings.today:
        return _timeText(context, '${translate(context, AppStrings.todaySmall)} ${formatChatTimesInHours(sentTime)}');
      case AppStrings.yesterday:
        return _timeText(context, '${translate(context, AppStrings.yesterdaySmall)} ${formatChatTimesInHours(sentTime)}');
    }
    return _timeText(context, formatChatTimesInDays(sentTime),);

  }
}

Widget _timeText(BuildContext context, String text){
  return CustomText(
    data: text,
    style: Theme.of(context).textTheme.bodySmall!.copyWith(
      fontSize: FontManager.s10,
      color: ColorManager.primaryColor,
    ),
  );
}