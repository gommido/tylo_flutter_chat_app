import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_internet_checker.dart';
import 'package:tylo/tylo/core/components/send_file_message_icon_widget.dart';
import 'package:tylo/tylo/presentation/controllers/audio_controller/audio_player_cubit.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/resources/constants/app_strings.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';
import '../../../controllers/file_picker_controller/file_picker_cubit.dart';
import '../../../controllers/firestore_controller/fire_store_cubit.dart';
import '../../../controllers/home_controller/home_cubit.dart';
import '../../../controllers/video_controller/video_cubit.dart';

class ChatRoomSendMessageFileIconWidget extends StatelessWidget {
  const ChatRoomSendMessageFileIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<ChatCubit, ChatState>(
      listener: (context, state){},
      builder: (context, state){
        return SendFileMessageIconWidget(
          visible: context.read<ChatCubit>().isSendImageIconTapped != null &&
              (context.read<FilePickerCubit>().pickedFile?.$2 == AppStrings.image ||
                  context.read<FilePickerCubit>().pickedFile?.$2 == AppStrings.video ||
                  context.read<FilePickerCubit>().pickedFile?.$2 == AppStrings.audio),
          onTap: (){
            context.read<ChatCubit>().setSendImageIconTapped(isTapped: null);
            CustomInternetChecker.checkInternetAvailability(
                context: context,
                onInternetAvailable: (){
                  if(context.read<FilePickerCubit>().pickedFile!.$2 == AppStrings.image){
                    context.read<ChatCubit>().sendImageFileMessage(
                      sentBy: context.read<HomeCubit>().id,
                      token: context.read<FireStoreCubit>().streamAppUser!.token,
                      receiverId:context.read<FireStoreCubit>().streamAppUser!.id,
                      receiverName:  context.read<FireStoreCubit>().streamAppUser!.name,
                      receiverImage:  context.read<FireStoreCubit>().streamAppUser!.photo,
                      secondUserPhotoVisibility: context.read<FireStoreCubit>().streamAppUser!.photoVisibility,
                      secondUserContacts: context.read<FireStoreCubit>().streamAppUser!.contacts,
                    );
                  }else if(context.read<FilePickerCubit>().pickedFile!.$2 == AppStrings.video){
                    if(context.read<VideoCubit>().isPlaying){
                      context.read<VideoCubit>().onPause(fileType: AppStrings.file);
                      context.read<VideoCubit>().onVideoFileControllerDispose();
                    }
                    context.read<ChatCubit>().sendVideoFileMessage(
                      sentBy: context.read<HomeCubit>().id,
                      token: context.read<FireStoreCubit>().streamAppUser!.token,
                      receiverId:context.read<FireStoreCubit>().streamAppUser!.id,
                      receiverName:  context.read<FireStoreCubit>().streamAppUser!.name,
                      receiverImage:  context.read<FireStoreCubit>().streamAppUser!.photo,
                      secondUserPhotoVisibility: context.read<FireStoreCubit>().streamAppUser!.photoVisibility,
                      secondUserContacts: context.read<FireStoreCubit>().streamAppUser!.contacts,
                    );
                  }else if(context.read<FilePickerCubit>().pickedFile!.$2 == AppStrings.audio){
                    if(context.read<AudioPlayerCubit>().player.playing){
                      context.read<AudioPlayerCubit>().onStop();
                    }
                    context.read<ChatCubit>().sendAudioFileMessage(
                      sentBy: context.read<HomeCubit>().id,
                      receiverId:  context.read<FireStoreCubit>().streamAppUser!.id,
                      receiverName:  context.read<FireStoreCubit>().streamAppUser!.name,
                      receiverImage:  context.read<FireStoreCubit>().streamAppUser!.photo,
                      audioPath: context.read<FilePickerCubit>().pickedFile!.$1!.path,
                      token: context.read<FireStoreCubit>().streamAppUser!.token,
                      voiceNoteDuration: context.read<AudioPlayerCubit>().duration,
                      isVoiceNote: false,
                      secondUserPhotoVisibility: context.read<FireStoreCubit>().streamAppUser!.photoVisibility,
                      secondUserContacts: context.read<FireStoreCubit>().streamAppUser!.contacts,
                    );
                  }
                },
            );
          },
        );
      },
    );
  }
}
