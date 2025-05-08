import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_builder.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_sized_box.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/presentation/controllers/call_controller/call_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/chat_controller/chat_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/home_controller/home_cubit.dart';
import 'package:tylo/tylo/presentation/pages/home_page/widgets/selected_items_count_to_delete_widget.dart';
import '../../../../core/components/custom_alert_dialog_widget.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/delete_icon_button_widget.dart';
import '../../../../core/helper_functions/navigator/navigator_pop.dart';
import '../../../../core/services/localization/localization.dart';

class SelectedItemsToDeleteWidget extends StatelessWidget {
  const SelectedItemsToDeleteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state){},
      builder: (context, state){
        return CustomRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SelectedItemsCountToDeleteWidget(),
            CustomBuilder(
              builder: (context){
                switch(context.read<HomeCubit>().currentIndex){
                  case 0:
                    return DeleteIconButtonWidget(
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CustomAlertDialogWidget(
                              title: translate(context, AppStrings.areYouSureDeleteTheseChats),
                              onPressed: (){
                                navigateAndPop(context);
                                context.read<HomeCubit>().pressDeleteLongPress();
                                context.read<ChatCubit>().deleteChatLastMessages(
                                  userId: context.read<HomeCubit>().id,
                                  ids:  context.read<ChatCubit>().selectedItems,
                                );
                                for(final id in context.read<ChatCubit>().selectedItems){
                                  context.read<ChatCubit>().deleteChat(
                                    sentBy: context.read<HomeCubit>().id,
                                    secondUserId: id,
                                  );
                                }
                                context.read<ChatCubit>().clearSelectedItems();
                              },
                            );

                          },
                        );

                      },
                    );
                  case 1:
                    return DeleteIconButtonWidget(
                      onPressed: (){
                        context.read<HomeCubit>().pressDeleteLongPress();
                        context.read<CallCubit>().deleteCalls(
                            userId: context.read<HomeCubit>().id,
                            ids: context.read<CallCubit>().myCalls.map((call)=> call.id).toList(),
                        );
                        context.read<ChatCubit>().clearSelectedItems();
                      },
                    );
                }
                return CustomSizedBox();
              },
            ),
          ],
        );
      },
    );
  }
}
