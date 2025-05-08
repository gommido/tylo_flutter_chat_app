import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_recorder/screen/social_media_recorder.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_sized_box.dart';
import 'package:tylo/tylo/core/helper_functions/get_record_time.dart';
import 'package:tylo/tylo/core/resources/color_manager.dart';
import 'package:tylo/tylo/presentation/controllers/group_controller/group_cubit.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/components/custom_widgets/custom_positioned.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';
import '../../../controllers/firestore_controller/fire_store_cubit.dart';
import '../../../controllers/home_controller/home_cubit.dart';

class SendVoiceNoteWidget extends StatelessWidget {
  const SendVoiceNoteWidget({super.key, required this.isGroupChatRoom, });
  final bool isGroupChatRoom;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumerWidget<ChatCubit, ChatState>(
      listener: (context, state) {},
      builder: (context, state) {
        if(context.read<ChatCubit>().isVoiceIconVisible != null){
          return CustomPositioned(
              right: size.width / 50,
              bottom: size.height / 10,
              child: SocialMediaRecorder(
                sendButtonIcon: CustomIcon(
                  icon: Icons.arrow_upward,
                  color: ColorManager.white ,
                ),
                backGroundColor: ColorManager.green,
                radius: BorderRadius.circular(10),
                recordIcon: CustomIcon(
                  icon: Icons.mic,
                  color: ColorManager.white,
                ),
                sendRequestFunction: (File soundFile, String time) {
                  if(soundFile.path.isNotEmpty){
                    final voiceNoteDuration = convertDurationToSeconds(time);
                    context.read<ChatCubit>().setVoiceIconVisibility(isVisible: null);
                    if(isGroupChatRoom){
                      context.read<GroupCubit>().sendGroupAudioFileMessage(
                        sentBy: context.read<HomeCubit>().id,
                        audioPath: soundFile.path,
                        voiceNoteDuration: voiceNoteDuration - 1,
                        isVoiceNote: true,
                      );
                    }else{
                      context.read<ChatCubit>().sendAudioFileMessage(
                        sentBy: context.read<HomeCubit>().id,
                        receiverId:  context.read<FireStoreCubit>().streamAppUser!.id,
                        receiverName:  context.read<FireStoreCubit>().streamAppUser!.name,
                        receiverImage:  context.read<FireStoreCubit>().streamAppUser!.photo,
                        audioPath: soundFile.path,
                        token: context.read<FireStoreCubit>().streamAppUser!.token,
                        voiceNoteDuration: voiceNoteDuration - 1,
                        isVoiceNote: true,
                        secondUserPhotoVisibility: context.read<FireStoreCubit>().streamAppUser!.photoVisibility,
                        secondUserContacts: context.read<FireStoreCubit>().streamAppUser!.contacts,
                      );
                    }
                  }
                },
              )
          );
        }
        return CustomSizedBox();
      },
    );
  }
}
