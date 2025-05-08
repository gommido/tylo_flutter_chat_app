import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/presentation/pages/chat_room_page/widgets/selected_messages_count_to_delete_widget.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/delete_icon_button_widget.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';
import '../../../controllers/firestore_controller/fire_store_cubit.dart';
import '../../../controllers/home_controller/home_cubit.dart';

class ChatRoomSelectedMessagesToDeleteWidget extends StatelessWidget {
  const ChatRoomSelectedMessagesToDeleteWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<ChatCubit, ChatState>(
      listener: (context, state){},
      builder: (context, state){
        return CustomRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SelectedMessagesCountToDeleteWidget(),
            DeleteIconButtonWidget(
              onPressed: (){
                if(context.read<ChatCubit>().selectedItems.contains(context.read<ChatCubit>().chatMessages.last.messageId)){
                  context.read<ChatCubit>().setLastMessageDeleteState(isDeleted: true);
                }
                context.read<ChatCubit>().deleteMessage(
                  firstUserId: context.read<HomeCubit>().id,
                  secondUserId: context.read<FireStoreCubit>().streamAppUser!.id,
                  ids: context.read<ChatCubit>().selectedItems,
                );
                context.read<ChatCubit>().deleteMessage(
                  firstUserId: context.read<FireStoreCubit>().streamAppUser!.id,
                  secondUserId: context.read<HomeCubit>().id,
                  ids: context.read<ChatCubit>().selectedItems,
                );

                context.read<ChatCubit>().clearSelectedItems();
                context.read<ChatCubit>().pressLongTime(isLongPressed: null);
              },
            ),
          ],
        );
      },
    );
  }
}
