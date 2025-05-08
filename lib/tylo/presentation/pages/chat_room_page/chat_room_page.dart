import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/bloc_consumer_widget.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_pop_scope.dart';
import 'package:tylo/tylo/presentation/controllers/call_controller/call_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/file_picker_controller/file_picker_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/home_controller/home_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/video_controller/video_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/chat_controller/chat_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/firestore_controller/fire_store_cubit.dart';
import 'package:tylo/tylo/presentation/pages/chat_room_page/widgets/chat_room_chat_cubit_listener_widget.dart';
import 'package:tylo/tylo/presentation/pages/chat_room_page/widgets/chat_room_file_picker_listener_widget.dart';
import 'package:tylo/tylo/presentation/pages/chat_room_page/widgets/chat_room_image_screen_fitted_widget.dart';
import 'package:tylo/tylo/presentation/pages/chat_room_page/widgets/chat_room_chatting_widget.dart';
import 'package:tylo/tylo/presentation/pages/chat_room_page/widgets/video_palyer_screen_fitted_widget.dart';
import '../../../core/components/custom_widgets/custom_builder.dart';
import '../../../core/helper_functions/navigator/navigator_pop.dart';
import '../../../core/resources/constants/firebase_constants.dart';
import '../../controllers/audio_controller/audio_player_cubit.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({super.key,});

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> with WidgetsBindingObserver {
  late ChatCubit _chatCubit;
  late VideoCubit  _videoCubit;
  late AudioPlayerCubit _audioPlayerCubit;

  @override
  void initState() {
    super.initState();
    _chatCubit = BlocProvider.of<ChatCubit>(context, listen:  false);
    _chatCubit.initChatMessageController();
    _chatCubit.clearSelectedItems();
    _chatCubit.getChatMessages(sentBy: BlocProvider.of<HomeCubit>(context, listen: false).id,);
    BlocProvider.of<FireStoreCubit>(context, listen: false).getUserAsStream(id: _chatCubit.otherChatUserId);
    BlocProvider.of<FireStoreCubit>(context, listen: false).updateAppUserData(
      id: BlocProvider.of<HomeCubit>(context, listen: false).id,
      field: FireBaseConstants.currentChatRoom,
      value: _chatCubit.otherChatUserId,
    );
    _chatCubit.updateUnSeenMessages(
      sentBy: BlocProvider.of<HomeCubit>(context, listen: false).id,
      sentTo: _chatCubit.otherChatUserId,
    );
    _videoCubit = BlocProvider.of<VideoCubit>(context, listen: false);
    _audioPlayerCubit = BlocProvider.of(context, listen: false);
    _audioPlayerCubit.initAudioData();
    BlocProvider.of<FilePickerCubit>(context, listen: false).nullifyPickedFileData();
    _chatCubit.setVoiceIconVisibility();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed){
      BlocProvider.of<FireStoreCubit>(context, listen: false).updateAppUserData(
        id: BlocProvider.of<HomeCubit>(context, listen: false).id,
        field: FireBaseConstants.lastSeen,
        value: null,
      );
      BlocProvider.of<FireStoreCubit>(context, listen: false).updateAppUserData(
        id: BlocProvider.of<HomeCubit>(context, listen: false).id,
        field: FireBaseConstants.currentChatRoom,
        value: _chatCubit.otherChatUserId,
      );
    }else{
      BlocProvider.of<FireStoreCubit>(context, listen: false).updateAppUserData(
        id: BlocProvider.of<HomeCubit>(context, listen: false).id,
        field: FireBaseConstants.lastSeen,
        value: Timestamp.now(),
      );
      BlocProvider.of<FireStoreCubit>(context, listen: false).updateAppUserData(
        id: BlocProvider.of<HomeCubit>(context, listen: false).id,
        field: FireBaseConstants.currentChatRoom,
        value: '',
      );
      if(BlocProvider.of<CallCubit>(context, listen: false).isRoomJoined != null &&
          BlocProvider.of<CallCubit>(context, listen: false).isRoomJoined!){

      }
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _chatCubit.disposeChatMessageController();
    _videoCubit.onVideoUrlControllerDispose();
    _videoCubit.onVideoFileControllerDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return customPopScope(
      canPop: false,
      onPopInvoked: (didPop){
        if (didPop) {
          return;
        }
        if(context.read<ChatCubit>().isEmojiShowing){
          context.read<ChatCubit>().toggleEmoji();
        }else if(context.read<ChatCubit>().isImageMessageScreenFitted != null){
          context.read<ChatCubit>().setImageMessageScreenFitState(isFitted: null);
        }
        else if(context.read<ChatCubit>().isVideoPlayerScreenFitted != null){
          context.read<ChatCubit>().setVideoPlayerScreenFitState(isFitted: null);
        }
        else{
          BlocProvider.of<FireStoreCubit>(context, listen: false).updateAppUserData(
            id: BlocProvider.of<HomeCubit>(context, listen: false).id,
            field: FireBaseConstants.currentChatRoom,
            value: '',
          );
          if(context.read<ChatCubit>().messageController.text.isNotEmpty){
            context.read<ChatCubit>().updateUserTypingStatus(
              sentBy: context.read<HomeCubit>().id,
              isTyping: false,
            );
            context.read<ChatCubit>().updateLastMessageTypingStatus(
              sentBy: context.read<HomeCubit>().id,
              receiverId: context.read<FireStoreCubit>().streamAppUser!.id,
              isTyping: false,
            );
          }
          context.read<ChatCubit>().clearChatMessages();
          navigateAndPop(context);
        }
      },
      child: ChatRoomFilePickerListenerWidget(
        child: ChatRoomChatCubitListenerWidget(
          child: BlocConsumerWidget<ChatCubit, ChatState>(
            listener: (context, state) {},
            builder: (context, state) {
              return CustomBuilder(
                builder: (context){
                  if(context.read<ChatCubit>().isVideoPlayerScreenFitted != null){
                    return const VideoPlayerScreenFittedWidget();
                  }else if(context.read<ChatCubit>().isImageMessageScreenFitted != null){
                    return const ChatRoomImageMessageScreenFittedWidget();
                  }
                  return const ChatRoomChattingWidget();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

