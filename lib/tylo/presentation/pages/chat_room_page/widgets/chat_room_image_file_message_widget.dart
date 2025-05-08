import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/loading_widget.dart';
import 'package:tylo/tylo/presentation/controllers/chat_controller/chat_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/file_picker_controller/file_picker_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/firestore_controller/fire_store_cubit.dart';
import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_expanded.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/components/image_file_message_widget.dart';
import '../../../../core/components/message_side_end_line_widget.dart';
import '../../../../core/components/message_side_start_line_widget.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../domain/entities/chat_message.dart';
import '../../../controllers/home_controller/home_cubit.dart';


class ChatRoomImageFileMessageWidget extends StatelessWidget {
  const ChatRoomImageFileMessageWidget({super.key, required this.chatMessage,});
  final ChatMessage chatMessage;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state){},
      builder: (context, state){
        final size = MediaQuery.of(context).size;
        return CustomRow(
          children: [
            MessageSideStartLineWidget(sentBy: chatMessage.sentBy,),
            CustomExpanded(
              child: ImageFileMessageWidget(
                    sentBy: chatMessage.sentBy,
                    senderName: context.read<FireStoreCubit>().streamAppUser != null ?
                    context.read<FireStoreCubit>().streamAppUser!.name : '',
                    messageText: chatMessage.messageText,
                    imageFile: context.read<FilePickerCubit>().pickedFile?.$1,
                    messageTime: chatMessage.messageTime,
                    isSeen: chatMessage.isSeen,
                    imageLowQuality: chatMessage.imageLowQuality,
                    messageId: chatMessage.messageId,
                   isGroupChatPage: false,
                  ),

            ),
            CustomColumn(
              children: [
                CustomGestureDetector(
                  onTap: (){
                    context.read<ChatCubit>().saveNetworkImage(imageUrl: chatMessage.messageText);
                  },
                  child: CustomBuilder(
                    builder: (context){
                      if(chatMessage.sentBy != context.read<HomeCubit>().id && chatMessage.messageText.isNotEmpty){
                        if(context.watch<ChatCubit>().isImageDownloading != null){
                          return const LoadingWidget(color: ColorManager.white);
                        }
                        return CustomIcon(
                          icon: Icons.download,
                          color: ColorManager.white,
                        );
                      }
                      return CustomSizedBox();
                    },
                  ),
                ),
                CustomSizedBox(height: size.height / 50,),
                CustomColumn(
                  children: [
                   CustomBuilder(
                     builder: (context){
                       if(chatMessage.sentBy !=context.read<HomeCubit>().id){
                         if(context.watch<ChatCubit>().isImageDownloading != null){
                           return  CustomContainer(
                             width: chatMessage.sentBy == context.read<HomeCubit>().id?
                             size.width / 3 : size.width / 9,
                             height: size.width / 200,
                             child: const LinearProgressIndicator(
                               backgroundColor: ColorManager.transparent,
                               color: ColorManager.green,
                             ),
                           );
                         }
                       }

                       return MessageSideEndLineWidget(
                         sentBy: chatMessage.sentBy,
                       );
                     },
                   ),

                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
