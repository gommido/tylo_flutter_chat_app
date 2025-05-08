import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/bloc_consumer_widget.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_builder.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_pop_scope.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_positioned.dart';
import 'package:tylo/tylo/presentation/controllers/agora_call_controller/agora_call_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/audio_controller/audio_player_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/call_controller/call_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/firestore_controller/fire_store_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/home_controller/home_cubit.dart';
import 'package:tylo/tylo/presentation/pages/video_call_page/widgets/agora_video_buttons_widget.dart';
import 'package:tylo/tylo/presentation/pages/video_call_page/widgets/agora_video_call_widget.dart';
import 'package:tylo/tylo/presentation/pages/video_call_page/widgets/agora_video_viewer_widget.dart';
import 'package:tylo/tylo/presentation/pages/video_call_page/widgets/call_background_image_widget.dart';
import 'package:tylo/tylo/presentation/pages/video_call_page/widgets/call_receiver_image_widget.dart';
import 'package:tylo/tylo/presentation/pages/video_call_page/widgets/call_receiver_name_widget.dart';
import 'package:tylo/tylo/presentation/pages/video_call_page/widgets/ongoing_call_title_widget.dart';
import 'package:tylo/tylo/presentation/pages/video_call_page/widgets/video_call_loading_widget.dart';
import 'package:tylo/tylo/presentation/pages/video_call_page/widgets/video_call_page_call_cubit_listener_widget.dart';
import '../../../core/components/animated_dots.dart';
import '../../../core/components/custom_widgets/custom_center.dart';
import '../../../core/components/custom_widgets/custom_column.dart';
import '../../../core/components/custom_widgets/custom_container.dart';
import '../../../core/components/custom_widgets/custom_scaffold.dart';
import '../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../core/components/custom_widgets/custom_stack.dart';

// ivV40CXnWSMKNiFSQwpjU8nSgex2
class VideoCallPage extends StatefulWidget {
  const VideoCallPage({super.key, required this.isCallMadeByMe});
  final bool isCallMadeByMe;

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> with WidgetsBindingObserver{
  late AgoraCallCubit _agoraCallCubit;
  late CallCubit _callCubit;
  late AudioPlayerCubit _audioPlayerCubit;

  @override
  void initState() {
    super.initState();
    _agoraCallCubit = BlocProvider.of<AgoraCallCubit>(context, listen: false);
    _callCubit = BlocProvider.of<CallCubit>(context, listen: false);
    _audioPlayerCubit = BlocProvider.of<AudioPlayerCubit>(context, listen: false);
    _agoraCallCubit.initAgoraClient();
    _agoraCallCubit.initializeAgora();
    _callCubit.getCallRoomCreatedByMe(
      userId: BlocProvider.of<HomeCubit>(context, listen: false).id,
    );
     BlocProvider.of<CallCubit>(context, listen: false).onAutoCallCancel();
    _callCubit.getCallDuration();
    if(!widget.isCallMadeByMe){
      BlocProvider.of<FireStoreCubit>(context, listen: false).getUserAsStream(id: _callCubit.room!.callerId);
    }
    WidgetsBinding.instance.addObserver(this);

  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.inactive){
      if(_audioPlayerCubit.player.playing){
        _audioPlayerCubit.onStop();
      }
    }

    super.didChangeAppLifecycleState(state);
  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if(_agoraCallCubit.client != null){
      _agoraCallCubit.releaseAgora();
    }
    if(_audioPlayerCubit.player.playing){
      _audioPlayerCubit.onStop();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumerWidget<AgoraCallCubit, AgoraCallState>(
      listener: (context, state) {
        if(state is InitializeAgoraState && widget.isCallMadeByMe){
          _audioPlayerCubit.playOngoingCallSound();
        }
      },
      builder: (context, state) {
        return VideoCallPageCallCubitListenerWidget(
          child: customPopScope(
            canPop: false,
            onPopInvoked: (didPop){
              if(didPop) return;
              _callCubit.setIsRoomJoinedData(isJoined: false);
            },
            child: CustomScaffold(
              body: SafeArea(
                child: CustomBuilder(
                  builder: (context){
                    if(_callCubit.room != null){
                      return const AgoraVideoCallWidget();
                    }
                    if(_agoraCallCubit.client != null && _agoraCallCubit.client!.isInitialized){
                      return CustomStack(
                        children: [
                          CustomBuilder(
                            builder: (context){
                              if(_callCubit.roomCreatedByMe != null && _callCubit.roomCreatedByMe!.isRespond){
                                return const AgoraVideoViewerWidget();
                              }
                              return CustomStack(
                                children: [
                                  const CallBackgroundImageWidget(),
                                  CustomCenter(
                                    child: CustomColumn(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const OngoingCallTitleWidget(),
                                        CustomSizedBox(height: size.height / 100,),
                                        const AnimatedDots(),
                                        CustomSizedBox(height: size.height / 25,),
                                        const CallReceiverImageWidget(),
                                        CustomSizedBox(height: size.height / 50,),
                                        const CallReceiverNameWidget(),
                                        CustomSizedBox(height: size.height / 25,),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          Builder(
                              builder: (context) {
                                if(_callCubit.roomCreatedByMe != null && _callCubit.roomCreatedByMe!.isRespond){
                                  return CustomSizedBox();
                                }
                                return CustomPositioned(
                                  right: 0, top: 0,
                                  child: CustomContainer(
                                    width: size.width / 3,
                                    height: size.width / 2,
                                    child:  const AgoraVideoViewerWidget(),
                                  ),
                                );
                              }
                          ),
                          const AgoraVideoButtonsWidget(),
                        ],
                      );
                    }
                    return CustomBuilder(
                      builder: (context){
                        if(_callCubit.roomCreatedByMe != null && _callCubit.roomCreatedByMe!.isRespond){
                          return CustomSizedBox();
                        }
                        return CustomStack(
                          children: [
                            const CallBackgroundImageWidget(),
                            CustomCenter(
                              child: CustomColumn(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const OngoingCallTitleWidget(),
                                  CustomSizedBox(height: size.height / 100,),
                                  const AnimatedDots(),
                                  CustomSizedBox(height: size.height / 25,),
                                  const CallReceiverImageWidget(),
                                  CustomSizedBox(height: size.height / 50,),
                                  const CallReceiverNameWidget(),
                                  CustomSizedBox(height: size.height / 25,),
                                ],
                              ),
                            ),
                            const VideoCallLoadingWidget(),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );

  }
}