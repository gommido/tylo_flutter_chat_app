import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/resources/constants/app_strings.dart';
import '../../../../domain/entities/chat_message.dart';
import 'chat_room_audio_message_widget.dart';
import 'chat_room_image_file_message_widget.dart';
import 'chat_room_text_message_widget.dart';
import 'chat_room_video_url_message_widget.dart';


class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget({super.key, required this.chatMessage, required this.index});
  final ChatMessage chatMessage;
  final int index;

  @override
  Widget build(BuildContext context) {
    if(chatMessage.messageText == AppStrings.messageDeleted){
      return ChatRoomTextMessageWidget(
        chatMessage: chatMessage,
      );
    }
    switch(chatMessage.messageType){
      case AppStrings.text || AppStrings.videoCall:
        return ChatRoomTextMessageWidget(
          chatMessage: chatMessage,
        );
      case AppStrings.image:
        return ChatRoomImageFileMessageWidget(
          chatMessage: chatMessage,
        );
      case AppStrings.video:
        return ChatRoomVideoUrlMessageWidget(
          chatMessage: chatMessage,
          index: index,
        );
      case AppStrings.audio || AppStrings.voiceNote:
        return ChatRoomAudioMessageWidget(chatMessage: chatMessage,);
    }
    return const SizedBox();

  }
}

