import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../../presentation/controllers/video_controller/video_cubit.dart';
import '../../presentation/pages/chat_room_page/widgets/message_video_player_widget.dart';
import '../resources/color_manager.dart';
import 'bloc_consumer_widget.dart';
import 'custom_widgets/custom_builder.dart';
import 'custom_widgets/custom_container.dart';
import 'custom_widgets/custom_gesture_detector.dart';
import 'custom_widgets/custom_icon.dart';
import 'custom_widgets/custom_sized_box.dart';
import 'custom_widgets/custom_stack.dart';

class VideoFileMessageViewerWidget extends StatelessWidget {
  const VideoFileMessageViewerWidget({super.key, required this.messageType, required this.messageText, required this.index, required this.videoMessageThumbnail});
  final String messageType;
  final String messageText;
  final int index;
  final String videoMessageThumbnail;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumerWidget<VideoCubit, VideoState>(
      listener: (context, state){},
      builder: (context, state){
        return CustomGestureDetector(
          onTap: (){
            if(messageType == AppStrings.video && messageText.isNotEmpty){
              if(context.read<VideoCubit>().videoUrlController == null){
                context.read<VideoCubit>().setCurrentVideo(currentIndex: index, currentUrl: messageText);
                context.read<VideoCubit>().initInternetVideoUrl(path: context.read<VideoCubit>().currentVideoUrl);
              }else{
                if(context.read<VideoCubit>().currentVideoIndex == index){
                  if(!context.read<VideoCubit>().isPlaying){
                    context.read<VideoCubit>().play(fileType: AppStrings.url);
                  }else{
                    context.read<VideoCubit>().onPause(fileType: AppStrings.url);

                  }
                }else{
                  context.read<VideoCubit>().setCurrentVideo(currentIndex: index, currentUrl: messageText);
                  if(context.read<VideoCubit>().videoUrlController!.value.isInitialized){
                    context.read<VideoCubit>().onPause(fileType: AppStrings.url);
                    context.read<VideoCubit>().initInternetVideoUrl(path: context.read<VideoCubit>().currentVideoUrl);
                  }

                }
              }
            }
          },
          child: CustomContainer(
            alignment: AlignmentDirectional.centerStart,
            height: size.height / 2.5,
            width: size.width / 2,
            child: CustomStack(
                children: [
                  CustomStack(
                    alignment: Alignment.center,
                    children: [
                      CustomContainer(
                        height: size.height / 2.5,
                        width: size.width / 2,
                        decoration: BoxDecoration(
                          color: ColorManager.black,
                          border: Border.all(
                              color: ColorManager.primaryColor.withOpacity(0.2)
                          ),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: videoMessageThumbnail,
                          fit: BoxFit.cover,
                        ),
                      ),
                      CustomBuilder(
                        builder: (context){
                          if(context.read<VideoCubit>().videoUrlController != null &&
                              !context.watch<VideoCubit>().isPlaying && index == context.read<VideoCubit>().currentVideoIndex){
                            return CustomSizedBox();
                          }
                          return  CustomIcon(
                            icon: Icons.play_circle,
                            color: ColorManager.white.withOpacity(0.5),
                            size: size.height / 20,
                          );
                        },
                      ),
                    ],
                  ),
                  CustomBuilder(
                    builder: (context) {
                      if(context.read<VideoCubit>().videoUrlController != null &&
                          context.read<VideoCubit>().isPlaying
                          && index == context.read<VideoCubit>().currentVideoIndex){
                        return MessageVideoPlayerWidget(index: index, isScreenFitted: false,);
                      }
                      return CustomSizedBox();
                    }
                  ),
                ]
            ),
          ),
        );
      },
    );
  }
}
