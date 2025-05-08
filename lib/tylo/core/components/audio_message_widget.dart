import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/controllers/audio_controller/audio_player_cubit.dart';
import '../../presentation/controllers/home_controller/home_cubit.dart';
import '../../presentation/pages/chat_room_page/widgets/is_message_seen_widget.dart';
import '../helper_functions/format_audio_duration.dart';
import '../resources/color_manager.dart';
import 'bloc_consumer_widget.dart';
import 'custom_audio_player_widget.dart';
import 'custom_widgets/custom_builder.dart';
import 'custom_widgets/custom_expanded.dart';
import 'custom_widgets/custom_row.dart';
import 'custom_widgets/custom_sized_box.dart';
import 'message_time_widget.dart';

class AudioMessageWidget extends StatelessWidget {
  AudioMessageWidget({super.key, required this.messageText, required this.messageTime, required this.sentBy, required this.isSeen, this.voiceNoteDuration, required this.isGroupChatRoom, required this.isMessage, required this.senderImage,});
  final String messageText;
  final Timestamp messageTime;
  final String sentBy;
  final String senderImage;
  final bool isSeen;
  final bool isGroupChatRoom;
  final bool isMessage;
  int? voiceNoteDuration;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomRow(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        BlocConsumerWidget<AudioPlayerCubit, AudioPlayerState>(
          listener: (context, state){},
          builder: (context, state){
            if(messageText.isEmpty){
              return CustomAudioPlayerWidget(
                senderImage: senderImage,
                isMessage: isMessage,
                width: size.width / 1.5,
                height: size.height / 10,
                audioPath: '',
                icon: Icons.play_circle,
                max: 0.0,
                value: 0.0,
                onChanged: (value){},
                position: '00:00',
                duration: '00.00',
                isLoading: true,
                onTap: (){},
              );
            }

            return CustomExpanded(
              child: CustomAudioPlayerWidget(
                senderImage: senderImage,
                isMessage: isMessage,
                width: size.width,
                height: size.height / 12,
                audioPath: messageText,
                icon: context.read<AudioPlayerCubit>().player.playing && context.read<AudioPlayerCubit>().currentAudioUrl == messageText ?
                Icons.pause :Icons.play_arrow,
                max: voiceNoteDuration == null ? 0.0 : voiceNoteDuration!.toDouble(),
                value: context.read<AudioPlayerCubit>().currentAudioUrl == messageText ?
                context.read<AudioPlayerCubit>().position.toDouble() : 0.0,
                onChanged: (double value){
                  if(context.read<AudioPlayerCubit>().currentAudioUrl == messageText){
                    context.read<AudioPlayerCubit>().onSeek(
                      position: value,
                    );
                  }
                },
                position: messageText == context.read<AudioPlayerCubit>().currentAudioUrl ? formatAudioDuration(context.read<AudioPlayerCubit>().position) : '00:00',
                duration: voiceNoteDuration == null ? '0.0' : formatAudioDuration(voiceNoteDuration!),
                isLoading: state is OnSetAudioPathLoadingState &&messageText == context.read<AudioPlayerCubit>().currentAudioUrl ,
                onTap: (){

                  if(context.read<AudioPlayerCubit>().currentAudioUrl == null){
                    context.read<AudioPlayerCubit>().setCurrentAudioUrl(
                      audioUrl: messageText,
                      duration: voiceNoteDuration!,
                    );
                    context.read<AudioPlayerCubit>().onSetAudioUrl(duration: 0);

                  }else{
                    if(context.read<AudioPlayerCubit>().currentAudioUrl == messageText){
                      if(context.read<AudioPlayerCubit>().player.playing){
                        context.read<AudioPlayerCubit>().onPause();
                      }else{
                        context.read<AudioPlayerCubit>().onPlay();
                      }
                    }else{
                      context.read<AudioPlayerCubit>().setCurrentAudioUrl(
                        audioUrl: messageText,
                        duration: voiceNoteDuration!,
                      );
                      context.read<AudioPlayerCubit>().onStop().then((onValue){
                        context.read<AudioPlayerCubit>().onSetAudioUrl(duration: 0);
                      });
                    }
                  }
                },
              ),
            );
          },
        ),
        CustomSizedBox(width: size.width / 50,),
        CustomRow(
          children: [
            MessageTimeWidget(messageTime: messageTime, color: ColorManager.white.withOpacity(0.7),),
            CustomSizedBox(width: size.width / 100,),
            CustomBuilder(
              builder: (context){
                if(!isGroupChatRoom){
                  if(sentBy == context.read<HomeCubit>().id){
                    return IsMessageSeenWidget(isSeen: isSeen,);
                  }
                }
                return CustomSizedBox();
              },
            ),
          ],
        ),
      ],
    );
  }
}
