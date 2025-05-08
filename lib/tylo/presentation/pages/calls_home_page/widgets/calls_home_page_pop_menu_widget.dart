import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_alert_dialog_widget.dart';
import '../../../../core/components/custom_widgets/custom_pop_menu_widget.dart';
import '../../../../core/components/custom_widgets/custom_snack_bar.dart';
import '../../../../core/helper_functions/navigator/navigator_pop.dart';
import '../../../../core/resources/constants/app_strings.dart';
import '../../../../core/services/localization/localization.dart';
import '../../../controllers/call_controller/call_cubit.dart';
import '../../../controllers/chat_controller/chat_cubit.dart';
import '../../../controllers/home_controller/home_cubit.dart';

class CallsHomePagePopMenuWidget extends StatelessWidget {
  const CallsHomePagePopMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<HomeCubit, HomeState>(
        listener: (context, state){},
        builder: (context, state){
          return CustomPopMenuWidget(
            onSelected: (value){
              if(context.read<ChatCubit>().lastMessages.isNotEmpty){
                if(value == translate(context, AppStrings.clearAllCalls)){
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CustomAlertDialogWidget(
                        title: translate(context, AppStrings.areYouSureClearAllCalls),
                        onPressed: (){
                          navigateAndPop(context);
                          context.read<HomeCubit>().pressDeleteLongPress();
                          context.read<CallCubit>().deleteCalls(
                            userId: context.read<HomeCubit>().id,
                            ids: context.read<CallCubit>().myCalls.map((call)=> call.id).toList(),
                          );
                        },
                      );
                    },
                  );
                }
              }else{
                CustomToast.show(title: translate(context, AppStrings.noCallsToClear),);
              }
            },
            itemBuilder: (context) => popMenuItemsWidget(
               [AppStrings.clearCallsLog],
              context,
            ),
          );
        });
  }
}
