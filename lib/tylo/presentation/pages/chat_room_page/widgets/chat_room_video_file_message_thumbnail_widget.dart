import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/bloc_consumer_widget.dart';
import 'package:tylo/tylo/domain/entities/chat_message.dart';
import 'package:tylo/tylo/presentation/controllers/chat_controller/chat_cubit.dart';

import '../../../../core/components/video_file_message_thumbnail_widget.dart';

class ChatRoomVideoFileMessageThumbnailWidget extends StatelessWidget {
  const ChatRoomVideoFileMessageThumbnailWidget({super.key, required this.chatMessage});
  final ChatMessage chatMessage;

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<ChatCubit, ChatState>(
        listener: (context, state){},
        builder: (context, state){
          return VideoFileMessageThumbnailWidget(
            messageText: chatMessage.messageText,
            videoMessageThumbnail: chatMessage.videoMessageThumbnail!,
            imageUploadingProgress: context.watch<ChatCubit>().imageUploadingProgress,
          );
        },
    );
  }
}
