import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/controllers/home_controller/home_cubit.dart';
import '../../presentation/pages/chat_room_page/widgets/is_message_seen_widget.dart';
import '../helper_functions/date_format.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import 'custom_widgets/custom_builder.dart';
import 'custom_widgets/custom_container.dart';
import 'custom_widgets/custom_positioned.dart';
import 'custom_widgets/custom_row.dart';
import 'custom_widgets/custom_sized_box.dart';
import 'custom_widgets/custom_text.dart';

class FileMessageBottomTimeSentWidget extends StatelessWidget {
  const FileMessageBottomTimeSentWidget({super.key, required this.messageTime, required this.isSeen, required this.sentBy});
  final String sentBy;
  final Timestamp messageTime;
  final bool isSeen;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomPositioned(
        bottom: size.height / 100,
        child: CustomContainer(
          width: size.width / 4,
          height: size.width / 15,
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: ColorManager.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: CustomRow(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                data: formatChatTimesInHours(messageTime,),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: ColorManager.white,
                    fontSize: FontManager.s10
                ),
              ),
              CustomSizedBox(width: size.width / 100,),
              CustomBuilder(
                builder: (context){
                  if(sentBy == context.read<HomeCubit>().id){
                    return IsMessageSeenWidget(
                      isSeen: isSeen,
                    );
                  }
                  return CustomSizedBox();
                },
              )
            ],
          ),
        )
    );
  }
}
