
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/chat_bottom_text_field_widget.dart';
import 'package:tylo/tylo/presentation/controllers/firestore_controller/fire_store_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/home_controller/home_cubit.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';

class ChatRoomBottomMessageTextFieldWidget extends StatelessWidget {
  const ChatRoomBottomMessageTextFieldWidget({super.key, required this.messageController, required this.bottomFocusNode,});
  final TextEditingController messageController;
  final FocusNode bottomFocusNode;

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
             onChanged: (String value){
               if(value.trim().isNotEmpty){
                 if(context.read<ChatCubit>().chatMessages.isNotEmpty){
                   context.read<ChatCubit>().updateUserTypingStatus(
                       sentBy: context.read<HomeCubit>().id,
                       isTyping: true,
                   );
                   context.read<ChatCubit>().updateLastMessageTypingStatus(
                     sentBy: context.read<HomeCubit>().id,
                     receiverId: context.read<FireStoreCubit>().streamAppUser!.id,
                     isTyping: true,
                   );
                 }
               }else{
                 if(context.read<ChatCubit>().chatMessages.isNotEmpty){
                   context.read<ChatCubit>().updateUserTypingStatus(
                     sentBy: context.read<HomeCubit>().id,
                     isTyping: false,
                   );
                   context.read<ChatCubit>().updateLastMessageTypingStatus(
                     sentBy: context.read<HomeCubit>().id,
                     receiverId: context.read<FireStoreCubit>().streamAppUser!.id,
                     isTyping: false,
                   );
                 }
               }
             },
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
