import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';
import '../../../controllers/file_picker_controller/file_picker_cubit.dart';
import '../../../controllers/video_controller/video_cubit.dart';

class ChatRoomFilePickerListenerWidget extends StatelessWidget {
  const ChatRoomFilePickerListenerWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<FilePickerCubit, FilePickerState>(
      listener: (context, state){
        if(state is PickFileSuccessState){
          if(context.read<FilePickerCubit>().pickedFile?.$2 == AppStrings.video){
            context.read<VideoCubit>().initVideoFile(file: context.read<FilePickerCubit>().pickedFile!.$1!);
            context.read<ChatCubit>().getVideoMessageThumbnail();
          }
          context.read<ChatCubit>().setSendImageIconTapped(isTapped: true);
        }
      },
      builder: (context, state) => child,
    );
  }
}
