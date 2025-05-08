import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_list_view_widget.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_pop_scope.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_sized_box.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';
import 'package:tylo/tylo/presentation/controllers/call_controller/call_cubit.dart';
import 'package:tylo/tylo/presentation/pages/calls_home_page/widgets/call_card_widget.dart';
import '../../../core/components/bloc_consumer_widget.dart';
import '../../../core/components/custom_widgets/custom_scaffold.dart';
import '../../../core/components/home_page_no_items_widget.dart';
import '../../../core/helper_functions/navigator/push_named_navigator.dart';
import '../../../core/resources/constants/app_routes.dart';
import '../../controllers/chat_controller/chat_cubit.dart';
import '../../controllers/home_controller/home_cubit.dart';
import '../../../core/components/custom_widgets/custom_floating_action_button_widget.dart';

class CallsHomePage extends StatelessWidget {
  const CallsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return customPopScope(
      canPop: false,
      onPopInvoked: (didPop){
        if (didPop) {
          return;
        }
        if(context.read<HomeCubit>().isLongPressed != null){
          context.read<HomeCubit>().pressDeleteLongPress();
          context.read<ChatCubit>().clearSelectedItems();
        }else{
          if(context.read<HomeCubit>().currentIndex != 0){
            context.read<HomeCubit>().changePage(0);
          }
        }
      },
      child: CustomScaffold(
        body: BlocConsumerWidget<CallCubit, CallState>(
          listener: (context, state){},
          builder: (context, state){
            if(context.read<CallCubit>().myCalls.isEmpty){
              return HomePageNoItemsWidget(
                title: translate(context, AppStrings.noCallsYet),
                icon: Icons.add_ic_call,
              );
            }
            return CustomListViewWidget(
              itemCount: context.watch<CallCubit>().myCalls.length,
              separatorBuilder: (context, index) => CustomSizedBox(height: size.height / 200,),
              itemBuilder: (context, index){
                final call = context.read<CallCubit>().myCalls[index];
                return CallCardWidget(call: call,);
              },
            );
          },
        ),
        floatingActionButton: CustomFloatingActionButtonWidget(
          onPressed: (){
            context.read<HomeCubit>().getPageTypeWhenNavigate(AppStrings.calls);
            pushNamed(context: context, route: AppRoutes.registeredContactsPage);
            if(context.read<HomeCubit>().isLongPressed != null){
              context.read<HomeCubit>().pressDeleteLongPress();
              context.read<ChatCubit>().clearSelectedItems();
            }
          },
          icon: Ionicons.call,
        ),
      ),
    );
  }
}
