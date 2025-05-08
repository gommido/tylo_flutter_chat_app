import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/presentation/controllers/audio_controller/audio_player_cubit.dart';

import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_snack_bar.dart';
import '../../../../core/helper_functions/navigator/navigator_pop.dart';
import '../../../../core/resources/constants/app_strings.dart';
import '../../../../core/resources/constants/firebase_constants.dart';
import '../../../../core/services/localization/localization.dart';
import '../../../../core/utils/message_type_enum.dart';
import '../../../controllers/call_controller/call_cubit.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';
import '../../../controllers/firestore_controller/fire_store_cubit.dart';
import '../../../controllers/home_controller/home_cubit.dart';

class VideoCallPageCallCubitListenerWidget extends StatelessWidget {
  const VideoCallPageCallCubitListenerWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<CallCubit, CallState>(
      listener: (context, state) {
        if(state is CreateRoomSuccessState){
          context.read<CallCubit>().createCall(
            secondUserId: context.read<FireStoreCubit>().streamAppUser!.id,
            secondUserName: context.read<FireStoreCubit>().streamAppUser!.name,
            secondUserImage: context.read<FireStoreCubit>().streamAppUser!.photo,
          );
        }
        if(state is SetIsRoomJoinedDataState && context.read<CallCubit>().isRoomJoined != null && !context.read<CallCubit>().isRoomJoined!){
          final duration = context.read<CallCubit>().calDuration;
          context.read<CallCubit>().cancelCallDurationTiming();
          if(context.read<CallCubit>().isCallMadeByMe != null){
            if(context.read<CallCubit>().isCallMadeByMe!){
              context.read<ChatCubit>().sendMessage(
                sentBy: context.read<HomeCubit>().id,
                sentTo:  context.read<FireStoreCubit>().streamAppUser!.id,
                messageText: AppStrings.videoCall,
                receiverName: context.read<FireStoreCubit>().streamAppUser!.name,
                receiverImage: context.read<FireStoreCubit>().streamAppUser!.photo,
                messageType: MessageType.videoCall,
                token: context.read<FireStoreCubit>().streamAppUser!.token,
                videoCallDuration: duration,
                secondUserPhotoVisibility: context.read<FireStoreCubit>().streamAppUser!.photoVisibility,
              );
              if(context.read<CallCubit>().roomCreatedByMe!.isRespond){
                context.read<CallCubit>().updateCallData(
                  id: context.read<HomeCubit>().id,
                  roomId: context.read<CallCubit>().roomCreatedByMe!.id,
                  field: FireBaseConstants.duration,
                  value: duration,
                );
                context.read<CallCubit>().updateCallData(
                  id: context.read<CallCubit>().roomCreatedByMe!.callReceiverId,
                  roomId:context.read<CallCubit>().roomCreatedByMe!.id,
                  field: FireBaseConstants.duration,
                  value: duration,
                );
              }
            }else{
              context.read<CallCubit>().updateCallData(
                id: context.read<HomeCubit>().id,
                roomId: context.read<CallCubit>().room!.id,
                field: FireBaseConstants.duration,
                value: duration,
              );
              context.read<CallCubit>().updateCallData(
                id: context.read<CallCubit>().room!.callReceiverId,
                roomId:context.read<CallCubit>().room!.id,
                field: FireBaseConstants.duration,
                value: duration,
              );
            }
          }
          context.read<CallCubit>().deleteRoom(
            roomId: context.read<CallCubit>().isCallMadeByMe != null &&
                context.read<CallCubit>().isCallMadeByMe! ?
            context.read<CallCubit>().roomCreatedByMe!.id :
            context.read<CallCubit>().room!.id,);
          context.read<CallCubit>().setIsRoomJoinedData();
          CustomToast.show(title: translate(context, AppStrings.callEnded));
          navigateAndPop(context);
        }
        if(state is OnAutoCallCancelSuccessState){
          if(context.read<AudioPlayerCubit>().player.playing){
            context.read<AudioPlayerCubit>().onStop();
          }
          if(context.read<CallCubit>().roomCreatedByMe != null && !context.read<CallCubit>().roomCreatedByMe!.isRespond){
            context.read<CallCubit>().deleteRoom(roomId: context.read<CallCubit>().roomCreatedByMe!.id,);
            navigateAndPop(context);
            context.read<ChatCubit>().sendMessage(
              sentBy: context.read<HomeCubit>().id,
              sentTo:  context.read<FireStoreCubit>().streamAppUser!.id,
              messageText: 'Video call',
              receiverName: context.read<FireStoreCubit>().streamAppUser!.name,
              receiverImage: context.read<FireStoreCubit>().streamAppUser!.photo,
              messageType: MessageType.videoCall,
              token: context.read<FireStoreCubit>().streamAppUser!.token,
              videoCallDuration: 0,
              secondUserPhotoVisibility: context.read<FireStoreCubit>().streamAppUser!.photoVisibility,

            );
            CustomToast.show(title: translate(context, AppStrings.callEnded));
          }
        }
        if(state is GetCallRoomCreatedByMeSuccessState && context.read<CallCubit>().roomCreatedByMe != null
            && context.read<CallCubit>().roomCreatedByMe!.isRespond){
          if(context.read<AudioPlayerCubit>().player.playing){
            context.read<AudioPlayerCubit>().onStop();
          }
        }
      },
      builder: (context, state) {
        return child;
      },
    );

  }
}
