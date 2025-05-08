import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_align_widget.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/domain/entities/group_message.dart';
import 'package:tylo/tylo/presentation/controllers/group_controller/group_cubit.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/selected_message_background_widget.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';
import '../../../controllers/home_controller/home_cubit.dart';
import 'group_chat_message_widget.dart';

class GroupChatRoomMessageWidget extends StatelessWidget {
  const GroupChatRoomMessageWidget({super.key, required this.groupMessage, required this.index});
  final GroupMessage groupMessage;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<GroupCubit, GroupState>(
      listener: (context, state){},
      builder: (context, state){
        return CustomAlignWidget(
          alignment: AlignmentDirectional.topStart,
          child: CustomGestureDetector(
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
            child: SelectedMessageBackgroundWidget(
              id: groupMessage.messageId,
              child: GroupChatMessageWidget(
                groupMessage: groupMessage,
                index: index,
              ),
            ),
          ),
        );
      },
    );
  }
}
