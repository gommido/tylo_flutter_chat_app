import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/bloc_consumer_widget.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_snack_bar.dart';
import '../../../../core/components/custom_alert_dialog_widget.dart';
import '../../../../core/components/custom_widgets/custom_pop_menu_widget.dart';
import '../../../../core/helper_functions/navigator/navigator_pop.dart';
import '../../../../core/resources/constants/app_strings.dart';
import '../../../../core/services/localization/localization.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';
import '../../../controllers/home_controller/home_cubit.dart';

class ChatHomePopMenuWidget extends StatelessWidget {
  const ChatHomePopMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<HomeCubit, HomeState>(
        listener: (context, state){},
        builder: (context, state){
          return CustomPopMenuWidget(
            onSelected: (value){
              if(context.read<ChatCubit>().lastMessages.isNotEmpty){
                if(value == translate(context, AppStrings.clearAllChats)){
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CustomAlertDialogWidget(
                        title: translate(context, AppStrings.areYouSureDeleteTheseChats),
                        onPressed: (){
                          navigateAndPop(context);
                          context.read<HomeCubit>().pressDeleteLongPress();
                          final chatsIds = context.read<ChatCubit>().lastMessages.map((message)=> message.secondUserId).toList();
                          context.read<ChatCubit>().deleteChatLastMessages(
                            userId: context.read<HomeCubit>().id,
                            ids: chatsIds,
                          );
                          for(final id in chatsIds){
                            context.read<ChatCubit>().deleteChat(
                              sentBy: context.read<HomeCubit>().id,
                              secondUserId: id,
                            );
                          }
                        },
                      );
                    },
                  );
                }
              }else{
                CustomToast.show(title: translate(context, AppStrings.noChatsToDelete),);
              }

            },
            itemBuilder: (context) => popMenuItemsWidget(
              [AppStrings.clearAllChats],
              context,
            ),
          );
        });
  }
}
