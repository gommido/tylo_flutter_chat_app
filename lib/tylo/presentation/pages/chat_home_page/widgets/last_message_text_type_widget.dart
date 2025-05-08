import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/domain/entities/last_message.dart';
import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_expanded.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/components/typing_now_widget.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../controllers/home_controller/home_cubit.dart';
import '../../chat_room_page/widgets/is_message_seen_widget.dart';

class LastMessageTextTypeWidget extends StatelessWidget {
  const LastMessageTextTypeWidget({super.key, required this.lastMessage});
  final LastMessage lastMessage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomBuilder(
        builder: (context) {
          if(lastMessage.isTyping){
            return const TypingNowWidget();
          }
          return CustomExpanded(
            child: CustomRow(
              children: [
                CustomExpanded(
                  child: CustomText(
                    data: lastMessage.messageText,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: lastMessage.sentBy == context.read<HomeCubit>().id ?
                      lastMessage.isSeen ?
                      ColorManager.white.withOpacity(0.5) :
                      ColorManager.white :
                      ColorManager.white.withOpacity(0.5),
                      overflow: TextOverflow.ellipsis,
                      fontWeight: lastMessage.isSeen ? null : FontWeight.bold,
                    ),
                  ),
                ),
                CustomBuilder(
                  builder: (context){
                    if(context.read<HomeCubit>().id == lastMessage.sentBy){
                      return CustomRow(
                        children: [
                          CustomSizedBox(width: size.width / 50),
                          IsMessageSeenWidget(
                            isSeen: lastMessage.isSeen,
                          ),
                        ],
                      );
                    }
                    return CustomSizedBox();
                  },
                ),
              ],
            ),
          );
        }
    );
  }
}
