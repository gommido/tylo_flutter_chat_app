import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';
import 'image_message_widget.dart';

class ImageFileMessageViewerWidget extends StatelessWidget {
  const ImageFileMessageViewerWidget({super.key, required this.sentBy, required this.senderName, required this.messageId, required this.messageText, required this.messageTime});
  final String sentBy;
  final String senderName;
  final String messageId;
  final String messageText;
  final Timestamp messageTime;

  @override
  Widget build(BuildContext context) {
    return CustomGestureDetector(
      onTap: (){
        context.read<ChatCubit>().setImageMessageScreenFitState(isFitted: true);
        context.read<ChatCubit>().setCurrentImageMessage(
          currentSenderId: sentBy,
          currentSenderName: senderName,
          currentImageMessageText: messageText,
          currentImageMessageTime: messageTime,
        );
      },
      child: ImageMessageWidget(messageText: messageText,),
    );
  }
}
