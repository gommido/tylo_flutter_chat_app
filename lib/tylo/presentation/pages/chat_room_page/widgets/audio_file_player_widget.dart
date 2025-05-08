import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/custom_audio_player_widget.dart';
import '../../../../core/helper_functions/format_audio_duration.dart';
import '../../../controllers/audio_controller/audio_player_cubit.dart';

class AudioFilePlayerWidget extends StatelessWidget {
  const AudioFilePlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<AudioPlayerCubit, AudioPlayerState>(
      listener: (context, state){},
      builder: (context, state){
        return CustomAudioPlayerWidget(
          senderImage: '',
          isMessage: false,
          width: size.width,
          height: size.height / 10,
          audioPath: '_',
          icon: context.read<AudioPlayerCubit>().player.playing ?
          Icons.pause_circle :Icons.play_circle,
          max: context.read<AudioPlayerCubit>().duration.toDouble(),
          value: context.read<AudioPlayerCubit>().position.toDouble(),
          onChanged: (double value){
            context.read<AudioPlayerCubit>().onSeek(
                position: value
            );
          },
          position: formatAudioDuration(context.read<AudioPlayerCubit>().position),
          duration: context.read<AudioPlayerCubit>().duration == 0 ?
          '00:00' : formatAudioDuration(context.read<AudioPlayerCubit>().duration),
          isLoading: false,
          onTap: (){
            if(context.read<AudioPlayerCubit>().player.playing){
              context.read<AudioPlayerCubit>().onPause();
            }else{
              context.read<AudioPlayerCubit>().onPlay();
            }
          },
        );
      },
    );
  }
}
