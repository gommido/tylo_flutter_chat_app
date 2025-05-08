import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/video_file_message_is_sending_widget.dart';
import '../../../controllers/local_storage_controller/local_storage_cubit.dart';

class GroupChatRoomIsSendingWidget extends StatelessWidget {
  const GroupChatRoomIsSendingWidget({super.key, required this.sentBy});
  final String sentBy;

  @override
  Widget build(BuildContext context) {
    return CustomBuilder(
      builder: (context){
        final name = context.read<LocalStorageCubit>().getStoredContactName(id: sentBy);
        return VideoFileMessageIsSendingWidget(
          sentBy: name,
        );
      },
    );
  }
}
