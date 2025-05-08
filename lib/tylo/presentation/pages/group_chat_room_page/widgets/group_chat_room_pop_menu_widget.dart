import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_pop_menu_widget.dart';
import 'package:tylo/tylo/core/helper_functions/navigator/navigator_pop.dart';
import 'package:tylo/tylo/presentation/controllers/group_controller/group_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/home_controller/home_cubit.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_alert_dialog_widget.dart';
import '../../../../core/components/custom_widgets/custom_bottom_sheet.dart';
import '../../../../core/resources/constants/app_strings.dart';
import '../../../../core/resources/constants/firebase_constants.dart';
import '../../../../core/services/localization/localization.dart';
import 'add_contact_to_group_widget.dart';
import 'remove_contact_from_group_widget.dart';

class GroupChatRoomPopMenuWidget extends StatelessWidget {
  const GroupChatRoomPopMenuWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<GroupCubit, GroupState>(
      listener: (context, state){
        if(state is UpdateGroupDataSuccessState){
          navigateAndPop(context);
        }

      },
      builder: (context, state){
        return CustomPopMenuWidget(
            onSelected: (value) {
              context.read<GroupCubit>().clearSelectedUsers();
              if(value == translate(context, AppStrings.addContact)){
                showModalBottomSheet(
                    context: context,
                    builder: (context){
                      return const AddContactToGroupWidget();
                    }
                );
              } else if(value == translate(context, AppStrings.removeContact)){
                CustomBottomSheet.showBottomSheet(
                  context: context,
                  child: const RemoveContactFromGroupWidget(),
                );
              }
              else{
                showDialog(context: context, builder: (context){
                  if(context.read<GroupCubit>().group!.ownerId == context.read<HomeCubit>().id){
                    return CustomAlertDialogWidget(
                      title: context.read<GroupCubit>().group!.ownerId == context.read<HomeCubit>().id ?
                      translate(context, AppStrings.doYouWantDeleteGroup) : translate(context, AppStrings.doYouWantExitGroup),
                      onPressed: (){
                        context.read<GroupCubit>().deleteGroup(id: context.read<GroupCubit>().group!.id);
                        navigateAndPop(context);
                      },
                    );
                  }
                  return CustomAlertDialogWidget(
                    title: translate(context, AppStrings.doYouWantExitGroup),
                    onPressed: (){
                      context.read<GroupCubit>().updateGroupData(
                        field: FireBaseConstants.membersIds,
                        value: FieldValue.arrayRemove([context.read<HomeCubit>().id ]),
                      );
                      navigateAndPop(context);
                    },
                  );

                });

              }
            },
            itemBuilder: (context){
              return popMenuItemsWidget(
                context.read<GroupCubit>().group!.ownerId == context.read<HomeCubit>().id ?
                context.read<GroupCubit>().groupPopMenuItems : [AppStrings.exitGroup],
                context,
              );
            },
        );
      },
    );

  }
}


