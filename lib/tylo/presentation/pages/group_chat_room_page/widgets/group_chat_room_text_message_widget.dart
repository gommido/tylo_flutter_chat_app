import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/chat_bubble_widget.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_gesture_detector.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';
import 'package:tylo/tylo/domain/entities/group_message.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/constants/app_strings.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';
import '../../../controllers/home_controller/home_cubit.dart';

class GroupChatRoomTextMessageWidget extends StatelessWidget {
  const GroupChatRoomTextMessageWidget({super.key, required this.groupMessage});
  final GroupMessage groupMessage;

  @override
  Widget build(BuildContext context) {
    return CustomGestureDetector(
      onTap: (){
        if(groupMessage.sentBy == context.read<HomeCubit>().id){
          if(groupMessage.messageText != AppStrings.messageDeleted){
            if(context.read<ChatCubit>().isLongPressed == null){
              context.read<ChatCubit>().selectItems(groupMessage.messageId);
            }else{
              if(context.read<ChatCubit>().selectedItems.length == 1 && context.read<ChatCubit>().selectedItems.contains(groupMessage.messageId)){
                context.read<ChatCubit>().clearSelectedItems();
                context.read<ChatCubit>().pressLongTime(isLongPressed: null);
              }else{
                if(!context.read<ChatCubit>().selectedItems.contains(groupMessage.messageId)){
                  context.read<ChatCubit>().selectItems(groupMessage.messageId);
                }else{
                  context.read<ChatCubit>().removeFromSelectedItems(groupMessage.messageId);
                }
              }
            }
          }
        }
      },
      onLongPress: (){
        if(groupMessage.sentBy == context.read<HomeCubit>().id){
          if(groupMessage.messageText != AppStrings.messageDeleted){
            if(context.read<ChatCubit>().selectedItems.isEmpty){
              context.read<ChatCubit>().pressLongTime(isLongPressed: true,);
              context.read<ChatCubit>().selectItems(groupMessage.messageId);
            }else{
              if(context.read<ChatCubit>().selectedItems.length == 1  && context.read<ChatCubit>().selectedItems.contains(groupMessage.messageId)){
                context.read<ChatCubit>().clearSelectedItems();
                context.read<ChatCubit>().pressLongTime(isLongPressed: null);
              }else if(!context.read<ChatCubit>().selectedItems.contains(groupMessage.messageId)){
                context.read<ChatCubit>().selectItems(groupMessage.messageId);
              }else{
                context.read<ChatCubit>().removeFromSelectedItems(groupMessage.messageId);
              }
            }
          }
        }
      },
      child: ChatBubbleWidget(
        sentBy: groupMessage.sentBy,
        imageUrl: groupMessage.senderImage,
        senderName: groupMessage.senderName,
        messageText: groupMessage.messageText,
        messageTime: groupMessage.messageTime,
        message: CustomText(
          data: groupMessage.messageText == AppStrings.messageDeleted ? translate(context, AppStrings.messageDeleted) : groupMessage.messageText,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: groupMessage.messageText != AppStrings.messageDeleted ? groupMessage.sentBy == context.read<HomeCubit>().id ?
            ColorManager.black : ColorManager.white :
            ColorManager.white,
            decoration: groupMessage.messageText == AppStrings.messageDeleted ?
            TextDecoration.lineThrough : null,
          ),
        ),
      ),
    );
  }
}
