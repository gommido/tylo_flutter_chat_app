import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_internet_checker.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/presentation/controllers/group_controller/group_cubit.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/send_file_message_icon_widget.dart';
import '../../../controllers/audio_controller/audio_player_cubit.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';
import '../../../controllers/file_picker_controller/file_picker_cubit.dart';
import '../../../controllers/home_controller/home_cubit.dart';
import '../../../controllers/video_controller/video_cubit.dart';

class GroupChatRoomSendFileMessageIconWidget extends StatelessWidget {
  const GroupChatRoomSendFileMessageIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<ChatCubit, ChatState>(
      listener: (context, state){},
      builder: (context, state){
        return SendFileMessageIconWidget(
          visible: context.read<ChatCubit>().isSendImageIconTapped != null &&
            (context.read<FilePickerCubit>().pickedFile?.$2 == AppStrings.image ||
            context.read<FilePickerCubit>().pickedFile?.$2 == AppStrings.video ||
            context.read<FilePickerCubit>().pickedFile?.$2 == AppStrings.audio),
          onTap: (){
            context.read<ChatCubit>().setSendImageIconTapped(isTapped: null);
            CustomInternetChecker.checkInternetAvailability(
                context: context,
                onInternetAvailable: (){
                  if(context.read<FilePickerCubit>().pickedFile!.$2 == AppStrings.image){
                    context.read<GroupCubit>().sendGroupImageFileMessage(
                      sentBy: context.read<HomeCubit>().id,
                    );
                  }else if(context.read<FilePickerCubit>().pickedFile!.$2 == AppStrings.video){
                    if(context.read<VideoCubit>().isPlaying){
                      context.read<VideoCubit>().onPause(fileType: AppStrings.file);
                      context.read<VideoCubit>().onVideoFileControllerDispose();
                    }
                    context.read<GroupCubit>().sendGroupVideoFileMessage(
                      sentBy: context.read<HomeCubit>().id,
                    );
                  }else if(context.read<FilePickerCubit>().pickedFile!.$2 == AppStrings.audio){
                    if(context.read<AudioPlayerCubit>().player.playing){
                      context.read<AudioPlayerCubit>().onStop();
                    }
                    context.read<GroupCubit>().sendGroupAudioFileMessage(
                      sentBy: context.read<HomeCubit>().id,
                      audioPath: context.read<FilePickerCubit>().pickedFile!.$1!.path,
                      voiceNoteDuration: context.read<AudioPlayerCubit>().duration,
                      isVoiceNote: false,
                    );
                  }
                },
            );
          },
        );
      },
    );
  }
}
