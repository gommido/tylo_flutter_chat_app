import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/custom_widgets/custom_circle_avatar.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../controllers/audio_controller/audio_player_cubit.dart';
import '../../../controllers/call_controller/call_cubit.dart';


class CallNotificationCancelCallWidget extends StatefulWidget {
  const CallNotificationCancelCallWidget({super.key});

  @override
  State<CallNotificationCancelCallWidget> createState() => _CallNotificationCancelCallWidgetState();
}

class _CallNotificationCancelCallWidgetState extends State<CallNotificationCancelCallWidget> {
  late AudioPlayerCubit _audioPlayerCubit;


  @override
  void initState() {
    super.initState();
    _audioPlayerCubit = BlocProvider.of<AudioPlayerCubit>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return CustomGestureDetector(
      onTap: (){
        _audioPlayerCubit.onStop();
        context.read<CallCubit>().cancelCallDurationTiming();
        context.read<CallCubit>().deleteRoom(roomId: context.read<CallCubit>().room!.id,);
      },
      child: CustomCircleAvatar(
        backgroundColor: ColorManager.red,
        radius: 25,
        child: CustomIcon(
          icon: Icons.call_end,
          color: ColorManager.white,
        ),
      ),
    );
  }
}
