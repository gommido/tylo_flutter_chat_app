import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/video_file_message_uploading_widget.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';

class ChatRoomVideoFileMessageUploadingWidget extends StatelessWidget {
  const ChatRoomVideoFileMessageUploadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<ChatCubit, ChatState>(
      listener: (context, state){},
      builder: (context, state){
        return VideoFileMessageUploadingWidget(
          videoThumbnail: context.watch<ChatCubit>().videoThumbnail,
          imageUploadingProgress: context.watch<ChatCubit>().imageUploadingProgress,
        );
      },
    );
  }
}
