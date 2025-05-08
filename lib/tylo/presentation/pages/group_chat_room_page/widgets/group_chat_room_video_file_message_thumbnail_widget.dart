import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/domain/entities/group_message.dart';
import 'package:tylo/tylo/presentation/controllers/group_controller/group_cubit.dart';

import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/video_file_message_thumbnail_widget.dart';

class GroupChatRoomVideoFileMessageThumbnailWidget extends StatelessWidget {
  const GroupChatRoomVideoFileMessageThumbnailWidget({super.key, required this.groupMessage});
  final GroupMessage groupMessage;

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<GroupCubit, GroupState>(
      listener: (context, state){},
      builder: (context, state){
        return VideoFileMessageThumbnailWidget(
          messageText: groupMessage.messageText,
          videoMessageThumbnail: groupMessage.videoMessageThumbnail!,
          imageUploadingProgress: context.watch<GroupCubit>().imageUploadingProgress,
        );
      },
    );
  }
}
