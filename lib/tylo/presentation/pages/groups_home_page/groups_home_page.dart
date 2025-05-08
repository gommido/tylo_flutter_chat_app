import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_list_view_widget.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_modal_progress_hud.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_pop_scope.dart';
import 'package:tylo/tylo/core/resources/constants/app_routes.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';
import 'package:tylo/tylo/presentation/controllers/group_controller/group_cubit.dart';
import '../../../core/components/bloc_consumer_widget.dart';
import '../../../core/components/custom_widgets/custom_builder.dart';
import '../../../core/components/custom_widgets/custom_scaffold.dart';
import '../../../core/components/home_page_no_items_widget.dart';
import '../../../core/helper_functions/navigator/push_named_navigator.dart';
import '../../controllers/home_controller/home_cubit.dart';
import 'widgets/group_card_widget.dart';
import '../../../core/components/custom_widgets/custom_floating_action_button_widget.dart';

class GroupsHomePage extends StatelessWidget {
  const GroupsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return customPopScope(
      canPop: false,
      onPopInvoked: (didPop){
        if (didPop) {
          return;
        }
        if(context.read<HomeCubit>().currentIndex != 0){
          context.read<HomeCubit>().changePage(0);
        }
      },
      child: CustomScaffold(
        body: BlocConsumerWidget<GroupCubit, GroupState>(
          listener: (context, state){},
          builder: (context, state){
            final size = MediaQuery.of(context).size;
            return CustomModalProgressHUD(
              inAsyncCall: state is DeleteGroupLoadingState,
              child: CustomBuilder(
                builder: (context) {
                  if(context.read<GroupCubit>().groups.isEmpty){
                    return HomePageNoItemsWidget(
                      title: translate(context, AppStrings.noGroupsYet),
                      icon: Icons.group_off_outlined,
                    );
                  }
                  return CustomListViewWidget(
                    separatorBuilder: (context, index) => SizedBox(height: size.height / 100,),
                      itemCount: context.read<GroupCubit>().groups.length,
                      itemBuilder: (context, index){
                        return GroupCardWidget(group:context.read<GroupCubit>().groups[index]);
                      }
                  );
                }
              ),
            );
          },
        ),
        floatingActionButton: CustomFloatingActionButtonWidget(
          onPressed: (){
            pushNamed(route: AppRoutes.newGroupPage, context: context);
          },
          icon: Ionicons.people,
        ),
      ),
    );
  }
}
