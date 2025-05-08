import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/presentation/controllers/group_controller/group_cubit.dart';

import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/video_file_message_uploading_widget.dart';

class GroupChatRoomVideoFileMessageUploadingWidget extends StatelessWidget {
  const GroupChatRoomVideoFileMessageUploadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<GroupCubit, GroupState>(
      listener: (context, state){},
      builder: (context, state){
        return VideoFileMessageUploadingWidget(
          videoThumbnail: context.watch<GroupCubit>().videoThumbnail,
          imageUploadingProgress: context.watch<GroupCubit>().imageUploadingProgress,
        );
      },
    );
  }
}
