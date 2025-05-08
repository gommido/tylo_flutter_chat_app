import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_gesture_detector.dart';
import 'package:tylo/tylo/core/components/loading_widget.dart';
import 'package:tylo/tylo/core/components/video_player_widget.dart';
import 'package:tylo/tylo/core/resources/color_manager.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/presentation/controllers/video_controller/video_cubit.dart';


class VideoViewerWidget extends StatefulWidget {
  const VideoViewerWidget({super.key});

  @override
  State<VideoViewerWidget> createState() => _VideoViewerWidgetState();
}

class _VideoViewerWidgetState extends State<VideoViewerWidget> {
  late VideoCubit _videoCubit;

  @override
  void initState() {
    _videoCubit = BlocProvider.of<VideoCubit>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _videoCubit.onVideoFileControllerDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideoCubit, VideoState>(
      listener: (context, state){},
      builder: (context, state){
        if(_videoCubit.videoFileController != null && _videoCubit.videoFileController!.value.isInitialized){
          return CustomGestureDetector(
            onTap: (){
              if(!_videoCubit.isPlaying){
                _videoCubit.play(fileType: AppStrings.file);
              }else{
                _videoCubit.onPause(fileType: AppStrings.file);
              }
            },
            child: VideoPlayerWidget(
              controller: _videoCubit.videoFileController,
              isPlaying: _videoCubit.isPlaying,
              isScreenFitted: false,
            ),
          );
        }
        return const LoadingWidget(color: ColorManager.primaryColor);
      },
    );
  }
}
