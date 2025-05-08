import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/presentation/controllers/group_controller/group_cubit.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/delete_icon_button_widget.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';
import '../../chat_room_page/widgets/selected_messages_count_to_delete_widget.dart';

class GroupChatRoomSelectedMessagesToDeleteWidget extends StatelessWidget {
  const GroupChatRoomSelectedMessagesToDeleteWidget({super.key});

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
                context.read<GroupCubit>().deleteGroupMessage(ids: context.read<ChatCubit>().selectedItems);
                context.read<ChatCubit>().clearSelectedItems();
                context.read<ChatCubit>().pressLongTime();
              },
            ),
          ],
        );
      },
    );
  }
}
