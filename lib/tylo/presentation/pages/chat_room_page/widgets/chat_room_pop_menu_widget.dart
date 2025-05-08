import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_internet_checker.dart';
import 'package:tylo/tylo/presentation/controllers/chat_controller/chat_cubit.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_alert_dialog_widget.dart';
import '../../../../core/components/custom_widgets/custom_pop_menu_widget.dart';
import '../../../../core/helper_functions/block_contact.dart';
import '../../../../core/helper_functions/navigator/navigator_pop.dart';
import '../../../../core/resources/constants/app_strings.dart';
import '../../../../core/services/localization/localization.dart';
import '../../../controllers/firestore_controller/fire_store_cubit.dart';
import '../../../controllers/home_controller/home_cubit.dart';

class ChatRoomPopMenuWidget extends StatelessWidget {
  const ChatRoomPopMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<ChatCubit, ChatState>(
      listener: (context, state){},
      builder: (context, state){
        return CustomPopMenuWidget(
          onSelected: (value){
            if(value == translate(context, AppStrings.deleteChat)){
              showDialog(
                context: context,
                builder: (context) {
                  return CustomAlertDialogWidget(
                    title: translate(context, AppStrings.deleteThisChat),
                    onPressed: (){
                      navigateAndPop(context);
                      if(context.read<ChatCubit>().chatMessages.isNotEmpty){
                        context.read<ChatCubit>().clearChatMessages();
                        navigateAndPop(context);
                        context.read<ChatCubit>().deleteChatLastMessages(
                          userId: context.read<HomeCubit>().id,
                          ids: [context.read<FireStoreCubit>().streamAppUser!.id],
                        );
                        context.read<ChatCubit>().deleteChat(
                          sentBy: context.read<HomeCubit>().id,
                          secondUserId: context.read<FireStoreCubit>().streamAppUser!.id,
                        );
                      }
                    },
                  );

                },
              );
            } else if(value == translate(context, AppStrings.blockContact)){
              CustomInternetChecker.checkInternetAvailability(
                  context: context,
                  onInternetAvailable: (){
                    blockContact(context: context);
                  },
              );
            }
          },
          itemBuilder: (context) => popMenuItemsWidget(
            context.read<ChatCubit>().chatRoomPopMenuItems,
            context,
          ),
        );
      },
    );
  }
}
