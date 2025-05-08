import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_sized_box.dart';
import 'package:tylo/tylo/presentation/controllers/video_controller/video_cubit.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_circle_avatar.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/components/custom_widgets/custom_positioned.dart';
import '../../../../core/components/custom_widgets/custom_stack.dart';
import '../../../../core/components/video_player_widget.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';

class MessageVideoPlayerWidget extends StatelessWidget {
  const MessageVideoPlayerWidget({super.key, required this.index, required this.isScreenFitted});
  final int index;
  final bool isScreenFitted;

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<VideoCubit, VideoState>(
      listener: (context, state){},
      builder: (context, state){
        final size = MediaQuery.of(context).size;
        return CustomStack(
          children: [
            VideoPlayerWidget(
              controller: context.read<VideoCubit>().videoUrlController,
              isPlaying: context.watch<VideoCubit>().isPlaying,
              isScreenFitted: isScreenFitted,
            ),
            CustomPositioned(
              right: context.read<ChatCubit>().isVideoPlayerScreenFitted != null ? 20 : 5,
              top: context.read<ChatCubit>().isVideoPlayerScreenFitted != null ? 10 : 0,
              child: CustomGestureDetector(
                onTap: (){
                  context.read<VideoCubit>().onSetVolume();
                },
                child: CustomCircleAvatar(
                  radius: size.width / 25,
                  backgroundColor: ColorManager.black.withOpacity(0.5),
                  child: CustomIcon(
                    icon: context.read<VideoCubit>().isMute == null ? Icons.volume_up : Icons.volume_off_sharp,
                    color: ColorManager.white,
                    size: size.width / 25,
                  ),
                ),
              ),
            ),
            CustomBuilder(
                builder: (context) {
                  if(context.read<ChatCubit>().isVideoPlayerScreenFitted != null){
                    return CustomPositioned(
                      left: context.read<ChatCubit>().isVideoPlayerScreenFitted != null ? 20 : 5,
                      top: context.read<ChatCubit>().isVideoPlayerScreenFitted != null ? 10 : 0,
                      child: CustomGestureDetector(
                        onTap: (){
                          context.read<VideoCubit>().onSetLoop();
                        },
                        child: CustomCircleAvatar(
                          radius: size.width / 25,
                          backgroundColor: context.read<VideoCubit>().isLoop == null ? ColorManager.black.withOpacity(0.5) : ColorManager.white,
                          child: CustomIcon(
                            icon: Icons.loop,
                            color: context.read<VideoCubit>().isLoop == null ? ColorManager.white : ColorManager.black,
                            size: size.width / 25,
                          ),
                        ),
                      ),
                    );
                  }
                  return CustomPositioned(
                    left: 5,
                    top: 0,
                    child: CustomGestureDetector(
                      onTap: (){
                        if(context.read<ChatCubit>().isVideoPlayerScreenFitted == null){
                          context.read<ChatCubit>().setVideoPlayerScreenFitState(isFitted: true);
                        }else{
                          context.read<ChatCubit>().setVideoPlayerScreenFitState(isFitted: null);

                        }
                      },
                      child: CustomCircleAvatar(
                        radius: size.width / 25,
                        backgroundColor: ColorManager.black.withOpacity(0.5),
                        child: CustomIcon(
                          icon: Icons.fit_screen,
                          color: ColorManager.white,
                          size: size.width / 25,
                        ),
                      ),
                    ),
                  );
                }
            ),
            CustomPositioned(
              bottom: 0,
              child: Builder(
                builder: (context) {
                  if(context.watch<VideoCubit>().isPlaying){
                    return LinearPercentIndicator(
                      padding: EdgeInsets.zero,
                      width: size.width / 2,
                      lineHeight: size.height / 200,
                      percent: context.watch<VideoCubit>().progress,
                      progressColor: ColorManager.green,
                    );
                  }
                  return CustomSizedBox();
                }
              ),
            ),

          ],
        );

      },
    );
  }
}
