import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../controllers/audio_controller/audio_player_cubit.dart';
import '../../../controllers/call_controller/call_cubit.dart';

class HomePageCallCubitListenerWidget extends StatefulWidget {
  const HomePageCallCubitListenerWidget({super.key, required this.child});
  final Widget child;

  @override
  State<HomePageCallCubitListenerWidget> createState() => _HomePageCallCubitListenerWidgetState();
}

class _HomePageCallCubitListenerWidgetState extends State<HomePageCallCubitListenerWidget> {
  late AudioPlayerCubit _audioPlayerCubit;


  @override
  void initState() {
    super.initState();
    _audioPlayerCubit = BlocProvider.of<AudioPlayerCubit>(context, listen: false);
    _audioPlayerCubit.initPlayerController();
  }

  @override
  void dispose() {
    _audioPlayerCubit.onDispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<CallCubit, CallState>(
      listener: (context, state){
        if(state is GetCallRoomSuccessState){
          if(context.read<CallCubit>().room != null){
            context.read<CallCubit>().onAutoCallCancel();
            if(!context.read<CallCubit>().room!.isRespond){
              _audioPlayerCubit.playIncomingCallSound();
            }
          }else{
            if(_audioPlayerCubit.player.playing){
              _audioPlayerCubit.onStop();
            }
          }
        }
        if(state is OnAutoCallCancelSuccessState && context.read<CallCubit>().room != null && !context.read<CallCubit>().room!.isRespond){
          if(_audioPlayerCubit.player.playing){
            _audioPlayerCubit.onStop();
          }
          if(context.read<CallCubit>().room != null && !context.read<CallCubit>().room!.isRespond){
            context.read<CallCubit>().deleteRoom(roomId: context.read<CallCubit>().room!.id,);
          }
        }
      },
      builder: (context, state){
        return widget.child;
      },
    );
  }
}
