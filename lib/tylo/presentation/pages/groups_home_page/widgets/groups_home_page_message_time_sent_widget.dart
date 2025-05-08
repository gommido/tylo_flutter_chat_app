import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/helper_functions/date_format.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';

class GroupsHomePageMessageTimeSentWidget extends StatelessWidget {
  const GroupsHomePageMessageTimeSentWidget({super.key, required this.timeSent});
  final Timestamp timeSent;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      data: '${formatChatTimesInDays(timeSent)} ${formatChatTimesInHours(timeSent)}',
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        fontSize: FontManager.s10,
        color: ColorManager.primaryColor,
      ),
    );
  }
}
