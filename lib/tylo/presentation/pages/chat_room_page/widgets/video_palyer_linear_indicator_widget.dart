import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../controllers/video_controller/video_cubit.dart';

class VideoPlayerLinearIndicatorWidget extends StatelessWidget {
  const VideoPlayerLinearIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumerWidget<VideoCubit, VideoState>(
      listener: (context, state){},
      builder: (context, state){
        final size = MediaQuery.of(context).size;
        return LinearPercentIndicator(
          padding: EdgeInsets.zero,
          width: size.width,
          lineHeight: size.height / 500,
          percent: context.watch<VideoCubit>().progress,
          progressColor: ColorManager.primaryColor,
        );
      },
    );
  }
}
