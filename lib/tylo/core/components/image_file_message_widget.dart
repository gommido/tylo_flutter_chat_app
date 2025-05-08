import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_builder.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_sized_box.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import '../../presentation/controllers/home_controller/home_cubit.dart';
import '../../presentation/pages/chat_room_page/widgets/image_file_message_uploading_widget.dart';
import '../../presentation/pages/chat_room_page/widgets/image_file_message_viewer_widget.dart';
import '../../presentation/pages/chat_room_page/widgets/image_message_widget.dart';
import 'custom_widgets/custom_stack.dart';
import 'file_message_bottom_time_sent_widget.dart';
import 'image_file_message_sender_file_loading_widget.dart';

class ImageFileMessageWidget extends StatelessWidget {
  ImageFileMessageWidget({super.key, required this.sentBy, required this.messageText, this.imageLowQuality, required this.messageTime, required this.messageId, this.isSeen, this.imageFile, required this.isGroupChatPage, required this.senderName});
  final String sentBy;
  final String senderName;
  final String messageId;
  final String messageText;
  final bool isGroupChatPage;
  String? imageLowQuality;
  final Timestamp messageTime;
  File? imageFile;
  bool? isSeen;

  @override
  Widget build(BuildContext context) {
    return CustomStack(
      alignment: Alignment.center,
      children: [
        CustomBuilder(
          builder: (context){
            if(messageText.isNotEmpty){
              return ImageFileMessageViewerWidget(
                sentBy: sentBy,
                messageText: messageText,
                senderName: senderName,
                messageId: messageId,
                messageTime: messageTime,
              );
            }
            if(sentBy == context.read<HomeCubit>().id){
              if(messageText.isEmpty && imageFile != null){
                return ImageFileMessageSenderFileLoadingWidget(
                  imageFile: imageFile!,
                  isGroupChatPage: isGroupChatPage,
                );
              }
            }else{
              if(messageText.isEmpty){
                if(imageLowQuality == null){
                  return ImageFileMessageUploadingWidget(sentBy: sentBy,);
                }
                return ImageMessageWidget(messageText: messageText,);
              }
            }
            return CustomSizedBox();
          },
        ),
        CustomBuilder(
          builder: (context){
            if(messageText != AppStrings.messageDeleted && isSeen != null){
              return FileMessageBottomTimeSentWidget(
                sentBy: sentBy,
                messageTime: messageTime,
                isSeen: isSeen!,
              );
            }
            return CustomSizedBox();
          },
        ),
      ],
    );
  }
}
