import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_sized_box.dart';
import 'package:tylo/tylo/core/resources/color_manager.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/presentation/controllers/chat_controller/chat_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/file_picker_controller/file_picker_cubit.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/video_viewer_widget.dart';
import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_positioned.dart';
import '../../../controllers/audio_controller/audio_player_cubit.dart';
import 'audio_file_player_widget.dart';
import 'image_file_viewer_widget.dart';

class FileMessageViewerBeforeSendingWidget extends StatelessWidget {
  const FileMessageViewerBeforeSendingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<ChatCubit, ChatState>(
      listener: (context, state){},
      builder: (context, state){
        final size = MediaQuery.of(context).size;
        return BlocConsumerWidget<FilePickerCubit, FilePickerState>(
          listener: (context, state){
            if(state is PickFileSuccessState && context.read<FilePickerCubit>().pickedFile?.$2 == AppStrings.audio){
              context.read<AudioPlayerCubit>().onSetAudioFile(
                assetPath: context.read<FilePickerCubit>().pickedFile!.$1!.path,
              );
            }
          },
          builder: (context, state){
            if(context.read<ChatCubit>().isSendImageIconTapped != null &&
                context.read<FilePickerCubit>().pickedFile != null){
              return CustomPositioned(
                top: 0,
                child: CustomContainer(
                    alignment: Alignment.center,
                    width: size.width / 1.5,
                    height: size.height / 2,
                    decoration: BoxDecoration(
                      color: context.read<FilePickerCubit>().pickedFile?.$2 == AppStrings.audio ?
                      ColorManager.transparent : ColorManager.grey,
                    ),
                    child: CustomBuilder(
                      builder: (context){
                        if(context.read<FilePickerCubit>().pickedFile != null){
                          if(context.read<FilePickerCubit>().pickedFile!.$2 == AppStrings.image){
                            return ImageFileViewerWidget(
                              width: size.width / 1.5,
                              height: size.height / 2,
                            );
                          }else if(context.read<FilePickerCubit>().pickedFile!.$2 == AppStrings.video){
                            return const VideoViewerWidget();
                          }else if(context.read<FilePickerCubit>().pickedFile!.$2 == AppStrings.audio){
                            return const AudioFilePlayerWidget();
                          }
                          return CustomSizedBox();

                        }
                        return CustomSizedBox();
                      },
                    )
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
