import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/presentation/controllers/group_controller/group_cubit.dart';

import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';
import '../../../controllers/file_picker_controller/file_picker_cubit.dart';
import '../../../controllers/video_controller/video_cubit.dart';

class GroupChatRoomFilePickerListenerWidget extends StatelessWidget {
  const GroupChatRoomFilePickerListenerWidget({super.key, required this.widget});
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<FilePickerCubit, FilePickerState>(
      listener: (context, state){
        if(state is PickFileSuccessState){
          if(context.read<FilePickerCubit>().pickedFile!.$2 == AppStrings.video){
            context.read<VideoCubit>().initVideoFile(file: context.read<FilePickerCubit>().pickedFile!.$1!);
            context.read<GroupCubit>().getVideoMessageThumbnail();
          }
          context.read<ChatCubit>().setSendImageIconTapped(isTapped: true);
        }
      },
      builder: (context, state) => widget,
    );
  }
}
