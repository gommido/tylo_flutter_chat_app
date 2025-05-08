import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/bottom_send_message_icon_widget.dart';
import 'package:tylo/tylo/presentation/controllers/home_controller/home_cubit.dart';
import '../../../../core/utils/message_type_enum.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';
import '../../../controllers/firestore_controller/fire_store_cubit.dart';

class ChatRoomBottomSendMessageIconWidget extends StatelessWidget {
  const ChatRoomBottomSendMessageIconWidget({super.key, required this.focusNode,});
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BottomSendMessageIconWidget(
        onPressed: (){
          if(context.read<ChatCubit>().messageController.text.isNotEmpty){
            if(focusNode.hasFocus){
              focusNode.unfocus();
            }
            context.read<ChatCubit>().sendMessage(
              sentBy: context.read<HomeCubit>().id,
              messageText: context.read<ChatCubit>().messageController.text,
              sentTo: context.read<FireStoreCubit>().streamAppUser!.id,
              receiverName: context.read<FireStoreCubit>().streamAppUser!.name,
              receiverImage: context.read<FireStoreCubit>().streamAppUser!.photo,
              messageType:  MessageType.text,
              token: context.read<FireStoreCubit>().streamAppUser!.token,
              secondUserPhotoVisibility: context.read<FireStoreCubit>().streamAppUser!.photoVisibility,
            );
            context.read<ChatCubit>().updateUserTypingStatus(
                sentBy: context.read<HomeCubit>().id,
                isTyping: false);
            if(context.read<ChatCubit>().chatMessages.isNotEmpty){
              context.read<ChatCubit>().updateLastMessageTypingStatus(
                sentBy: context.read<HomeCubit>().id,
                receiverId: context.read<FireStoreCubit>().streamAppUser!.id,
                isTyping: false,
              );
            }
          }
          context.read<ChatCubit>().clearChatMessageText();
          if(context.read<ChatCubit>().isEmojiShowing){
            context.read<ChatCubit>().toggleEmoji();
          }
        }

    );
  }
}
