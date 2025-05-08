import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/domain/entities/group_message.dart';

import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/components/video_file_message_viewer_widget.dart';
import '../../../controllers/home_controller/home_cubit.dart';
import 'group_chat_room_is_sending_widget.dart';
import 'group_chat_room_video_file_message_thumbnail_widget.dart';
import 'group_chat_room_video_file_message_uploading_widget.dart';

class GroupChatRoomVideoMessageWidget extends StatelessWidget {
  const GroupChatRoomVideoMessageWidget({super.key, required this.groupMessage, required this.index});
  final GroupMessage groupMessage;
  final int index;

  @override
  Widget build(BuildContext context) {
    if(groupMessage.messageText.isNotEmpty){
      return VideoFileMessageViewerWidget(
        messageText: groupMessage.messageText,
        messageType: groupMessage.messageType,
        index: index,
        videoMessageThumbnail: groupMessage.videoMessageThumbnail!,
      );
    }
    if(groupMessage.sentBy == context.read<HomeCubit>().id){
      if(groupMessage.videoMessageThumbnail == null){
        return const GroupChatRoomVideoFileMessageUploadingWidget();
      }
      return GroupChatRoomVideoFileMessageThumbnailWidget(
        groupMessage: groupMessage,
      );
    }else{
      if(groupMessage.videoMessageThumbnail == null){
        return GroupChatRoomIsSendingWidget(sentBy: groupMessage.sentBy,);
      }
      return CustomSizedBox();
    }
  }
}
