import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/presentation/controllers/audio_controller/audio_player_cubit.dart';

import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/resources/constants/app_strings.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';
import '../../../controllers/file_picker_controller/file_picker_cubit.dart';
import '../../../controllers/video_controller/video_cubit.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/components/custom_widgets/custom_circle_avatar.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/components/custom_widgets/custom_positioned.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';

class UnSendMessageFileIconWidget extends StatelessWidget {
  const UnSendMessageFileIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<ChatCubit, ChatState>(
      listener: (context, state){},
      builder: (context, state){
        final size = MediaQuery.of(context).size;
        return BlocConsumerWidget<FilePickerCubit, FilePickerState>(
          listener: (context, state){},
          builder: (context, state){
            if(context.read<ChatCubit>().isSendImageIconTapped != null &&
                (context.read<FilePickerCubit>().pickedFile?.$2 == AppStrings.image ||
                    context.read<FilePickerCubit>().pickedFile?.$2 == AppStrings.video ||
                    context.read<FilePickerCubit>().pickedFile?.$2 == AppStrings.audio)){
              return CustomPositioned(
                bottom: 100,
                right: 0,
                child: CustomRow(
                  children: [
                    BlocConsumerWidget<VideoCubit, VideoState>(
                      listener: (context, state){},
                      builder: (context, state){
                        return CustomGestureDetector(
                          onTap: (){
                            if(context.read<FilePickerCubit>().pickedFile?.$2 == AppStrings.audio){
                              if(context.read<VideoCubit>().isPlaying){
                                context.read<VideoCubit>().onPause(fileType: AppStrings.file);
                                context.read<VideoCubit>().onVideoFileControllerDispose();
                              }
                              if(context.read<AudioPlayerCubit>().player.playing){
                                context.read<AudioPlayerCubit>().onStop();
                              }
                            }
                            context.read<ChatCubit>().setSendImageIconTapped(isTapped: null);
                          },
                          child: CustomCircleAvatar(
                            radius: 20,
                            backgroundColor: ColorManager.red.withOpacity(0.5),
                            child: CustomIcon(
                              icon: Icons.close,
                              color: ColorManager.white,
                            ),
                          ),
                        );
                      },
                    ),
                    CustomSizedBox(width: size.width / 100,),
                    CustomContainer(
                      width: size.height / 10,
                      height: size.width / 200,
                      decoration: BoxDecoration(
                        color: ColorManager.primaryColor.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
              );
            }
            return CustomSizedBox();
          },
        );
      },
    );
  }
}
