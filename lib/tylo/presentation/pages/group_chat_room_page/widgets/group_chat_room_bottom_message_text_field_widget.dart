
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/chat_bottom_text_field_widget.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';

class GroupChatRoomBottomMessageTextFieldWidget extends StatelessWidget {
  const GroupChatRoomBottomMessageTextFieldWidget({super.key, required this.messageController, required this.bottomFocusNode, required this.isGroupMessage,});
  final TextEditingController messageController;
  final FocusNode bottomFocusNode;
  final bool isGroupMessage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumerWidget<ChatCubit, ChatState>(
      listener: (context, state) {},
       builder: (context, state) {
         return CustomSizedBox(
           height: size.height / 18,
           child: ChatBottomTextFieldWidget(
             focusNode: bottomFocusNode,
             controller: messageController,
             onChanged: (String value){},
             onTap: (){
               if(bottomFocusNode.hasFocus){
                 bottomFocusNode.unfocus();
               }
               if(context.read<ChatCubit>().isEmojiShowing){
                 context.read<ChatCubit>().toggleEmoji();
               }
             },
           ),
         );
       },
);
  }
}
