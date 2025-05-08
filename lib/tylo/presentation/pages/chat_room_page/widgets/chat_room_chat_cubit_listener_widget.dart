import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_snack_bar.dart';
import '../../../../core/utils/message_type_enum.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';
import '../../../controllers/firestore_controller/fire_store_cubit.dart';
import '../../../controllers/home_controller/home_cubit.dart';

class ChatRoomChatCubitListenerWidget extends StatelessWidget {
  const ChatRoomChatCubitListenerWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<ChatCubit, ChatState>(
      listener: (context, state){
        if(state is DeleteMessageSuccessState && context.read<ChatCubit>().isLastMessageDeleted != null){
          Future.delayed(const Duration(seconds: 2)).then((value){
            for(final m in context.read<ChatCubit>().chatMessages.reversed.toList()){
              print(m.messageText);
            }
            for(final message in context.read<ChatCubit>().chatMessages.reversed.toList()){
              if(message.messageText != AppStrings.messageDeleted){
                context.read<ChatCubit>().setLastMessage(
                  sentBy: context.read<HomeCubit>().id,
                  secondUserId: context.read<ChatCubit>().chatMessages.last.sentBy == context.read<HomeCubit>().id ? context.read<FireStoreCubit>().streamAppUser!.id : context.read<HomeCubit>().id,
                  secondUserName: context.read<ChatCubit>().chatMessages.last.sentBy == context.read<HomeCubit>().id ? context.read<FireStoreCubit>().streamAppUser!.name : context.read<FireStoreCubit>().currentAppUser!.name,
                  secondUserImage: context.read<ChatCubit>().chatMessages.last.sentBy == context.read<HomeCubit>().id ? context.read<FireStoreCubit>().streamAppUser!.photo : context.read<FireStoreCubit>().currentAppUser!.photo,
                  lastMessage: message.messageText,
                  messageTime: context.read<ChatCubit>().chatMessages.last.messageTime,
                  messageType: context.read<ChatCubit>().chatMessages.last.messageType == AppStrings.text ? MessageType.text :
                  context.read<ChatCubit>().chatMessages.last.messageType == AppStrings.image ? MessageType.image :
                  context.read<ChatCubit>().chatMessages.last.messageType == AppStrings.video ?  MessageType.video :
                  MessageType.voiceNote,
                  secondUserPhotoVisibility: context.read<FireStoreCubit>().streamAppUser!.photoVisibility,
                );
                break;
              }
            }

          });
        }
        if(state is GetChatMessagesSuccessState && context.read<FireStoreCubit>().currentAppUser!.currentChatRoom.isNotEmpty){
          context.read<ChatCubit>().checkIfUserIsInBottom();
          context.read<ChatCubit>().getUnSeenMessagesCount(senderId: BlocProvider.of<HomeCubit>(context, listen: false).id,);
        }
        if(state is CheckIfUserIsInBottomState && context.read<ChatCubit>().isUserAtBottom != null && context.read<ChatCubit>().isUserAtBottom!){
          context.read<ChatCubit>().updateUnSeenMessages(
            sentBy: BlocProvider.of<HomeCubit>(context, listen: false).id,
            sentTo: context.read<ChatCubit>().otherChatUserId,
          );
          if(context.read<ChatCubit>().chatMessages.isNotEmpty && context.read<ChatCubit>().chatMessages.last.sentBy != context.read<HomeCubit>().id){
            context.read<ChatCubit>().updateUnSeenLastMessage(sentBy: context.read<HomeCubit>().id,);
          }
        }
        if(state is DeleteMessageSuccessState){
          CustomToast.show(title: translate(context, AppStrings.messageDeleted));
        }
        if(state is DeleteChatLastMessageSuccessState){
          context.read<ChatCubit>().deleteChat(
            sentBy: context.read<HomeCubit>().id,
            secondUserId: context.read<FireStoreCubit>().streamAppUser!.id,
          );
        }

      },
      builder: (context, state)=> child,
    );
  }
}
