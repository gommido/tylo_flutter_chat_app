import 'package:flutter/material.dart';
import '../../../../core/components/chat_room_wallpaper_widget.dart';
import '../../../../core/components/custom_widgets/custom_column.dart';
import 'group_chat_room_bottom_widget.dart';
import 'group_chat_room_messages_list_widget.dart';

class GroupChatRoomBodyWidget extends StatelessWidget {
  const GroupChatRoomBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomColumn(
      children: const [
        ChatRoomWallpaperWidget(
          child: GroupChatRoomMessagesListWidget(),
        ),
        GroupChatRoomBottomWidget(),
      ],
    );
  }
}
