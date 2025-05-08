import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_pop_scope.dart';
import 'package:tylo/tylo/presentation/controllers/chat_controller/chat_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/group_controller/group_cubit.dart';
import 'package:tylo/tylo/presentation/pages/group_chat_room_page/widgets/group_chat_room_chatting_widget.dart';
import 'package:tylo/tylo/presentation/pages/group_chat_room_page/widgets/group_chat_room_file_picker_listener_widget.dart';
import '../../../core/components/bloc_consumer_widget.dart';
import '../../../core/components/custom_widgets/custom_builder.dart';
import '../../../core/helper_functions/navigator/navigator_pop.dart';
import '../../controllers/audio_controller/audio_player_cubit.dart';
import '../../controllers/video_controller/video_cubit.dart';
import '../chat_room_page/widgets/chat_room_image_screen_fitted_widget.dart';
import '../chat_room_page/widgets/video_palyer_screen_fitted_widget.dart';


class GroupChatRoomPage extends StatefulWidget {
   const GroupChatRoomPage({super.key, required this.groupId,});
   final String groupId;

  @override
  State<GroupChatRoomPage> createState() => _GroupChatRoomPageState();
}

class _GroupChatRoomPageState extends State<GroupChatRoomPage> {
  late GroupCubit _groupCubit;
  late VideoCubit  _videoCubit;
  late AudioPlayerCubit _audioPlayerCubit;



  @override
  void initState() {
    _groupCubit = BlocProvider.of<GroupCubit>(context, listen: false);
    _groupCubit.initChatMessageController();
    _groupCubit.getGroupDetails(id: widget.groupId,);
    _groupCubit.getGroupMessages(groupId: widget.groupId);
    _videoCubit = BlocProvider.of<VideoCubit>(context, listen: false);
    _audioPlayerCubit = BlocProvider.of(context, listen: false);
    BlocProvider.of<ChatCubit>(context, listen: false).clearSelectedItems();
    _audioPlayerCubit.initAudioData();
    super.initState();
  }

  @override
  void dispose() {
    _groupCubit.disposeChatMessageController();
    _videoCubit.onVideoUrlControllerDispose();
    _videoCubit.onVideoFileControllerDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<GroupCubit, GroupState>(
      listener: (context, state){
        if(state is DeleteGroupSuccessState){
          navigateAndPop(context);
        }
      },
        builder: (context, state){
          return customPopScope(
            canPop: false,
            onPopInvoked: (didPop){
              if(didPop) return;
              if(context.read<ChatCubit>().isEmojiShowing){
                context.read<ChatCubit>().toggleEmoji();
              }else if(context.read<ChatCubit>().isImageMessageScreenFitted != null){
                context.read<ChatCubit>().setImageMessageScreenFitState(isFitted: null);
              }
              else if(context.read<ChatCubit>().isVideoPlayerScreenFitted != null){
                context.read<ChatCubit>().setVideoPlayerScreenFitState(isFitted: null);
              }
              else{
                context.read<ChatCubit>().clearChatMessages();
                context.read<ChatCubit>().setSendImageIconTapped();
                navigateAndPop(context);
              }
            },
            child: CustomBuilder(
              builder: (context) {
                return GroupChatRoomFilePickerListenerWidget(
                  widget: BlocConsumerWidget<ChatCubit, ChatState>(
                    listener: (context, state){},
                    builder: (context, state){
                      if(context.read<ChatCubit>().isVideoPlayerScreenFitted != null){
                        return const VideoPlayerScreenFittedWidget();
                      }else if(context.read<ChatCubit>().isImageMessageScreenFitted != null){
                        return const ChatRoomImageMessageScreenFittedWidget();
                      }
                      return const GroupChatRoomChattingWidget();

                    },
                  ),
                );
              }
            ),
          );
        },
    );
  }
}

