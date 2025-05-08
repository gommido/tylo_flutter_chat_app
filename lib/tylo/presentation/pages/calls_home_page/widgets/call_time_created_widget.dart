
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/helper_functions/date_format.dart';
import '../../../../core/resources/color_manager.dart';

class CallTimeCreatedWidget extends StatelessWidget {
  const CallTimeCreatedWidget({super.key, required this.callCreated, required this.isDialed});
  final Timestamp callCreated;
  final bool isDialed;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      data: '${formatChatTimesInDays(callCreated) } ${formatChatTimesInHours(callCreated)}',
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        color: isDialed ? ColorManager.white : ColorManager.red,
      ),
    );
  }
}
