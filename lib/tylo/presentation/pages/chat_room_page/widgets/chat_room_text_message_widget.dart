
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/chat_bubble_widget.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_builder.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_icon.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_sized_box.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../domain/entities/chat_message.dart';
import '../../../controllers/home_controller/home_cubit.dart';

class ChatRoomTextMessageWidget extends StatelessWidget {
  const ChatRoomTextMessageWidget({super.key, required this.chatMessage,});
  final ChatMessage chatMessage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChatBubbleWidget(
        sentBy: chatMessage.sentBy,
        messageText: chatMessage.messageText,
        messageTime: chatMessage.messageTime,
        imageUrl: '',
        isSeen:  chatMessage.isSeen,
        message: CustomBuilder(
        builder: (context){
          if(chatMessage.messageType == AppStrings.videoCall){
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomIcon(
                  icon: Icons.missed_video_call,
                  color: ColorManager.red,
                ),
                CustomSizedBox(width: size.width / 50,),
                CustomText(
                  data: chatMessage.messageText == AppStrings.messageDeleted ? translate(context, AppStrings.messageDeleted) : chatMessage.messageText,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: chatMessage.messageText != AppStrings.messageDeleted ? chatMessage.sentBy == context.read<HomeCubit>().id ?
                    ColorManager.black : ColorManager.white :
                    ColorManager.white,
                    decoration: chatMessage.messageText == AppStrings.messageDeleted ?
                    TextDecoration.lineThrough : null,
                  ),
                ),
              ],
            );
          }
          return CustomText(
            data: chatMessage.messageText == AppStrings.messageDeleted ? translate(context, AppStrings.messageDeleted) : chatMessage.messageText,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: chatMessage.messageText != AppStrings.messageDeleted ? chatMessage.sentBy == context.read<HomeCubit>().id ?
              ColorManager.black : ColorManager.white :
              ColorManager.white,
              decoration: chatMessage.messageText == AppStrings.messageDeleted ?
              TextDecoration.lineThrough : null,
            ),
          );
        },
      )
    );
  }
}



