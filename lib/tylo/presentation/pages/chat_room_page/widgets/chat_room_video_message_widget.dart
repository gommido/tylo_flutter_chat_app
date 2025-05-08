import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/domain/entities/chat_message.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/components/video_file_message_viewer_widget.dart';
import '../../../controllers/home_controller/home_cubit.dart';
import 'chat_room_is_sending_widget.dart';
import 'chat_room_video_file_message_thumbnail_widget.dart';
import 'chat_room_video_file_message_uploading_widget.dart';

class ChatRoomVideoMessageWidget extends StatelessWidget {
  const ChatRoomVideoMessageWidget({super.key, required this.chatMessage, required this.index});
  final ChatMessage chatMessage;
  final int index;

  @override
  Widget build(BuildContext context) {
    if(chatMessage.messageText.isNotEmpty){
      return VideoFileMessageViewerWidget(
        messageText: chatMessage.messageText,
        messageType: chatMessage.messageType,
        index: index,
        videoMessageThumbnail: chatMessage.videoMessageThumbnail!,
      );
    }
    if(chatMessage.sentBy == context.read<HomeCubit>().id){
      if(chatMessage.videoMessageThumbnail == null){
        return const ChatRoomVideoFileMessageUploadingWidget();
      }
      return ChatRoomVideoFileMessageThumbnailWidget(chatMessage: chatMessage,);
    }else{
      if(chatMessage.videoMessageThumbnail == null){
        return ChatRoomIsSendingWidget(sentBy: chatMessage.sentBy,);
      }
      return CustomSizedBox();
    }
  }
}
