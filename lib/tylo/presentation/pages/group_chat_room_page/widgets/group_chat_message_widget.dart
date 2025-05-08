
import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/presentation/controllers/group_controller/group_cubit.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../domain/entities/group_message.dart';
import 'group_chat_room_audio_message_widget.dart';
import 'group_chat_room_image_file_message_widget.dart';
import 'group_chat_room_text_message_widget.dart';
import 'group_chat_room_video_url_message_widget.dart';

class GroupChatMessageWidget extends StatelessWidget {
  const GroupChatMessageWidget({super.key, required this.groupMessage, required this.index});
  final GroupMessage groupMessage;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<GroupCubit, GroupState>(
        listener: (context, state){},
        builder: (context, state){
          if(groupMessage.messageText == AppStrings.messageDeleted){
            return GroupChatRoomTextMessageWidget(
              groupMessage: groupMessage,
            );
          }
          switch(groupMessage.messageType){
            case AppStrings.text:
              return GroupChatRoomTextMessageWidget(
                groupMessage: groupMessage,
              );
            case AppStrings.image:
              return GroupChatRoomImageFileMessageWidget(groupMessage: groupMessage,);
            case AppStrings.video:
              return GroupChatRoomVideoUrlMessageWidget(
                groupMessage: groupMessage,
                index: index,
              );
            case AppStrings.audio || AppStrings.voiceNote:
              return GroupChatRoomAudioMessageWidget(groupMessage: groupMessage,);
          }
          return const SizedBox();
        },
    );
  }
}
