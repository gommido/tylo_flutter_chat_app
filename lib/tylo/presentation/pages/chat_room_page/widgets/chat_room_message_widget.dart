import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/domain/entities/chat_message.dart';
import 'package:tylo/tylo/presentation/controllers/chat_controller/chat_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/home_controller/home_cubit.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/selected_message_background_widget.dart';
import '../../../controllers/video_controller/video_cubit.dart';
import 'chat_message_widget.dart';

class ChatRoomMessageWidget extends StatelessWidget {
  const ChatRoomMessageWidget({super.key, required this.message, required this.index});
  final ChatMessage message;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<ChatCubit, ChatState>(
      listener: (context, state){},
      builder: (context, state){
        return BlocConsumerWidget<VideoCubit, VideoState>(
          listener: (context, state){},
          builder: (context, state){
            return CustomGestureDetector(
              onTap: (){
                if(context.read<ChatCubit>().isLongPressed != null){
                  if(message.sentBy == context.read<HomeCubit>().id){
                    if(message.messageText != AppStrings.messageDeleted){
                      if(context.read<ChatCubit>().selectedItems.length == 1 && context.read<ChatCubit>().selectedItems.contains(message.messageId)){
                        context.read<ChatCubit>().clearSelectedItems();
                        context.read<ChatCubit>().pressLongTime(isLongPressed: null);
                      }else{
                        if(!context.read<ChatCubit>().selectedItems.contains(message.messageId)){
                          context.read<ChatCubit>().selectItems(message.messageId);
                        }else{
                          context.read<ChatCubit>().removeFromSelectedItems(message.messageId);
                        }
                      }
                    }
                  }
                }
              },
              onLongPress: (){
                if(message.sentBy == context.read<HomeCubit>().id){
                  if(message.messageText != 'MessageDeleted'){
                    if(context.read<ChatCubit>().selectedItems.isEmpty){
                      context.read<ChatCubit>().pressLongTime(isLongPressed: true,);
                      context.read<ChatCubit>().selectItems(message.messageId);
                    }else{
                      if(context.read<ChatCubit>().selectedItems.length == 1  && context.read<ChatCubit>().selectedItems.contains(message.messageId)){
                        context.read<ChatCubit>().clearSelectedItems();
                        context.read<ChatCubit>().pressLongTime(isLongPressed: null);
                      }else if(!context.read<ChatCubit>().selectedItems.contains(message.messageId)){
                        context.read<ChatCubit>().selectItems(message.messageId);
                      }else{
                        context.read<ChatCubit>().removeFromSelectedItems(message.messageId);
                      }
                    }
                  }
                }
              },
              child: SelectedMessageBackgroundWidget(
                id: message.messageId,
                child: ChatMessageWidget(
                  chatMessage: message,
                  index: index,
                ),
              )
            );
          },
        );
      },
    );
  }
}
