import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/bottom_send_message_icon_widget.dart';

import '../../../../core/utils/message_type_enum.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';
import '../../../controllers/group_controller/group_cubit.dart';
import '../../../controllers/home_controller/home_cubit.dart';

class GroupChatRoomBottomSendMessageIconWidget extends StatelessWidget {
  const GroupChatRoomBottomSendMessageIconWidget({super.key, required this.focusNode});
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BottomSendMessageIconWidget(
      onPressed: (){
        if(context.read<GroupCubit>().groupMessageController.text.isNotEmpty){
          if(focusNode.hasFocus){
            focusNode.unfocus();
          }
          context.read<GroupCubit>().sendGroupMessage(
            sentBy: context.read<HomeCubit>().id,
            messageText: context.read<GroupCubit>().groupMessageController.text,
            messageType: MessageType.text,
          );
          if(context.read<ChatCubit>().isEmojiShowing){
            context.read<ChatCubit>().toggleEmoji();
          }
          context.read<GroupCubit>().clearGroupChatMessageText();
        }
      },
    );
  }
}
