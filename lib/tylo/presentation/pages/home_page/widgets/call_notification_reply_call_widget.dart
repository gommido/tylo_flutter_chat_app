import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/presentation/controllers/home_controller/home_cubit.dart';
import '../../../../core/components/custom_widgets/custom_circle_avatar.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/helper_functions/navigator/push_named_navigator.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/constants/app_routes.dart';
import '../../../../core/resources/constants/firebase_constants.dart';
import '../../../controllers/audio_controller/audio_player_cubit.dart';
import '../../../controllers/call_controller/call_cubit.dart';


class CallNotificationReplyCallWidget extends StatefulWidget {
  const CallNotificationReplyCallWidget({super.key,});

  @override
  State<CallNotificationReplyCallWidget> createState() => _CallNotificationReplyCallWidgetState();
}

class _CallNotificationReplyCallWidgetState extends State<CallNotificationReplyCallWidget> {
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
        if(_audioPlayerCubit.player.playing){
          _audioPlayerCubit.onStop();
        }
        context.read<CallCubit>().updateRoomData(
          field: FireBaseConstants.isRespond,
          value: true,
        );
        pushNamed(route: AppRoutes.videoCallPage, context: context.read<HomeCubit>().navigatorKey.currentState!.context, arguments: false,);
        context.read<CallCubit>().setIsRoomJoinedData(isJoined: true);
      },
      child: CustomCircleAvatar(
        backgroundColor: ColorManager.green,
        radius: 25,
        child: CustomIcon(
          icon: Icons.call_end,
          color: ColorManager.white,
        ),
      ),
    );
  }
}
