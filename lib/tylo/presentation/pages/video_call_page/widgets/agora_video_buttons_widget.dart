import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/bloc_consumer_widget.dart';

import '../../../controllers/agora_call_controller/agora_call_cubit.dart';
import '../../../controllers/audio_controller/audio_player_cubit.dart';
import '../../../controllers/call_controller/call_cubit.dart';

class AgoraVideoButtonsWidget extends StatelessWidget {
  const AgoraVideoButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<AudioPlayerCubit, AudioPlayerState>(
        listener: (context, state){},
        builder: (context, state){
          return AgoraVideoButtons(
            client: context.read<AgoraCallCubit>().client!,
            onDisconnect: (){
              if(context.read<AudioPlayerCubit>().player.playing){
                context.read<AudioPlayerCubit>().onStop();
              }
              context.read<CallCubit>().setIsRoomJoinedData(isJoined: false);
            },
          );
        },
    );
  }
}
