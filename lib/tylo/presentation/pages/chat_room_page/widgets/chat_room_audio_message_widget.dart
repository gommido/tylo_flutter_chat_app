import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/domain/entities/chat_message.dart';
import 'package:tylo/tylo/presentation/controllers/firestore_controller/fire_store_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/home_controller/home_cubit.dart';
import '../../../../core/components/audio_message_widget.dart';

class ChatRoomAudioMessageWidget extends StatelessWidget {
  const ChatRoomAudioMessageWidget({super.key, required this.chatMessage});
  final ChatMessage chatMessage;

  @override
  Widget build(BuildContext context) {
    return AudioMessageWidget(
      messageText: chatMessage.messageText,
      sentBy: chatMessage.sentBy,
      senderImage: chatMessage.sentBy == context.read<HomeCubit>().id ?
      context.read<FireStoreCubit>().currentAppUser!.photo : context.read<FireStoreCubit>().streamAppUser!.id,
      messageTime: chatMessage.messageTime,
      isSeen: chatMessage.isSeen,
      isMessage: true,
      isGroupChatRoom: false,
      voiceNoteDuration: chatMessage.voiceNoteDuration,
    );
  }
}
