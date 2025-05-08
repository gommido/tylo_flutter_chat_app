import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/helper_functions/date_format.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';

class DateHeaderWidget extends StatelessWidget {
  const DateHeaderWidget({super.key, required this.showDateHeader, required this.messageTime});
  final bool showDateHeader;
  final Timestamp messageTime;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomBuilder(
      builder: (context){
        if(showDateHeader){
          return CustomContainer(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            width: size.width / 3,
            height: size.height / 30,
            decoration: BoxDecoration(
                color: ColorManager.teal.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10)
            ),
            child: CustomText(
              data: formatChatTimesInDays(messageTime),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: FontManager.s08,
              ),
            ),
          );
        }
        return CustomSizedBox();
      },
    );
  }
}
