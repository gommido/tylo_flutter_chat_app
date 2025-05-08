import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_stack.dart';
import 'package:tylo/tylo/core/resources/constants/app_routes.dart';
import 'package:tylo/tylo/presentation/controllers/home_controller/home_cubit.dart';
import 'package:tylo/tylo/domain/entities/last_message.dart';
import 'package:tylo/tylo/presentation/controllers/chat_controller/chat_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/local_storage_controller/local_storage_cubit.dart';
import 'package:tylo/tylo/presentation/pages/chat_home_page/widgets/last_message_user_image_widget.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_expanded.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/helper_functions/navigator/push_named_navigator.dart';
import '../../../../core/resources/color_manager.dart';
import '../../chat_home_page/widgets/deleted_chat_icon_widget.dart';
import '../../chat_home_page/widgets/last_message_receiver_name_widget.dart';
import '../../chat_home_page/widgets/last_message_time_sent_widget.dart';
import '../../chat_home_page/widgets/last_message_title_widget.dart';

class LastMessageWidget extends StatelessWidget {
  const LastMessageWidget({super.key, required this.lastMessage});
  final LastMessage lastMessage;

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<ChatCubit, ChatState>(
      listener: (context, state){},
      builder: (context, state){
        final size = MediaQuery.of(context).size;
        final name = context.read<LocalStorageCubit>().getStoredContactName(id: lastMessage.secondUserId);
        return CustomGestureDetector(
          onTap: (){
            if(context.read<ChatCubit>().selectedItems.isEmpty){
              context.read<ChatCubit>().setOtherChatUserId(lastMessage.secondUserId);
              pushNamed(route: AppRoutes.chatRoomPage, context: context,);
            }else{
              if(context.read<ChatCubit>().selectedItems.length == 1 && context.read<ChatCubit>().selectedItems.contains(lastMessage.secondUserId)){
                context.read<ChatCubit>().clearSelectedItems();
                context.read<HomeCubit>().pressDeleteLongPress();
              }else{
                if(!context.read<ChatCubit>().selectedItems.contains(lastMessage.secondUserId)){
                  context.read<ChatCubit>().selectItems(lastMessage.secondUserId);
                }else{
                  context.read<ChatCubit>().removeFromSelectedItems(lastMessage.secondUserId);
                }
              }
            }

           },
          onLongPress: (){
            if(context.read<ChatCubit>().selectedItems.isEmpty){
              context.read<HomeCubit>().pressDeleteLongPress(isLongPressed: true,);
              context.read<ChatCubit>().selectItems(lastMessage.secondUserId);
            }else{
              if(context.read<ChatCubit>().selectedItems.length == 1  && context.read<ChatCubit>().selectedItems.contains(lastMessage.secondUserId)){
                context.read<ChatCubit>().clearSelectedItems();
                context.read<HomeCubit>().pressDeleteLongPress();
              }else if(!context.read<ChatCubit>().selectedItems.contains(lastMessage.secondUserId)){
                context.read<ChatCubit>().selectItems(lastMessage.secondUserId);
              }else{
                context.read<ChatCubit>().removeFromSelectedItems(lastMessage.secondUserId);
              }
            }
          },
          child: CustomContainer(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            width: size.width,
            height: size.height / 10,
            decoration: BoxDecoration(
              color: context.read<HomeCubit>().isLongPressed != null
                  && context.read<ChatCubit>().selectedItems.contains(lastMessage.secondUserId) ?
              ColorManager.grey.withOpacity(0.5) : Colors.transparent,
              border: Border.all(
                color: Colors.grey.withOpacity(0.02),
              )
            ),
            child: CustomRow(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomStack(
                  alignment: Alignment.center,
                  children: [
                    LastMessageUserImageWidget(
                      imageUrl: lastMessage.secondUserImage,
                      sentBy: lastMessage.sentBy,
                      isSeen: lastMessage.isSeen,
                      secondUserId: lastMessage.secondUserId,
                      secondUserPhotoVisibility: lastMessage.secondUserPhotoVisibility,
                    ),
                    const DeletedChatIconWidget(),
                  ],
                ),
                CustomSizedBox(width: size.width / 50),
                CustomExpanded(
                  child: CustomColumn(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomRow(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LastMessageReceiverNameWidget(
                            name: name.isNotEmpty ? name : lastMessage.secondUserName,
                            userId: lastMessage.secondUserId,
                          ),
                          LastMessageTimeSentWidget(
                            sentTime: lastMessage.messageTime,
                          ),
                        ],
                      ),
                      CustomSizedBox(height: size.height / 100),
                      LastMessageTitleWidget(
                        lastMessage: lastMessage,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
        },
    );
  }
}
