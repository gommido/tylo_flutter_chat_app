import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_builder.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_expanded.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_gesture_detector.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_list_view_widget.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_row.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_sized_box.dart';
import 'package:tylo/tylo/core/helper_functions/navigator/navigator_pop.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/presentation/controllers/group_controller/group_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/local_storage_controller/local_storage_cubit.dart';

import '../../presentation/pages/create_new_group_page/widgets/picked_contact_icon_widget.dart';
import '../../presentation/pages/group_chat_room_page/widgets/add_or_remove_member_button_widget.dart';
import '../../presentation/pages/group_chat_room_page/widgets/empty_contacts_widget.dart';
import '../../presentation/pages/registered_contacts_page/widgets/contact_card_widget.dart';
import '../resources/color_manager.dart';
import 'bloc_consumer_widget.dart';
import 'custom_widgets/custom_column.dart';
import 'custom_widgets/custom_container.dart';

class CustomAddOrRemoveContactsFromGroupWidget extends StatelessWidget {
  const CustomAddOrRemoveContactsFromGroupWidget({super.key, required this.isContain, required this.isAdding});
  final bool isContain;
  final bool isAdding;

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<GroupCubit, GroupState>(
      listener: (context, state){},
      builder: (context, state){
        final size = MediaQuery.of(context).size;
        return CustomContainer(
            height: size.height / 2,
            width: size.width,
            decoration: const BoxDecoration(
              color: ColorManager.backgroundColor,
            ),
            child: CustomBuilder(
              builder: (context,){
                if(context.read<LocalStorageCubit>().storedRegisteredContacts.isEmpty){
                  return const EmptyContactsWidget();
                }
                return CustomColumn(
                  children: [
                    CustomExpanded(
                      child: CustomListViewWidget(
                        separatorBuilder: (context, index)=> CustomSizedBox(),
                        itemCount: context.read<LocalStorageCubit>().storedRegisteredContacts.length,
                        itemBuilder: (context, index) {
                          bool contain;
                          final contact = context.read<LocalStorageCubit>().storedRegisteredContacts[index];
                          context.read<GroupCubit>().isContactPicked.add(false);
                          if(isContain){
                            contain = context.read<GroupCubit>().group!.membersIds.contains(contact.id);
                          }else{
                            contain = !context.read<GroupCubit>().group!.membersIds.contains(contact.id);
                          }
                          if(contain){
                            return CustomGestureDetector(
                              onTap: (){
                                context.read<GroupCubit>().pickGroupMembers(index);
                                if(context.read<GroupCubit>().isContactPicked[index]){
                                  context.read<GroupCubit>().addContactToSelected(contact.id,);
                                } else{
                                  context.read<GroupCubit>().removeContactFromSelected(contact.id,);
                                }
                              },
                              child: CustomContainer(
                                padding: const EdgeInsets.all(10.0),
                                width: size.width,
                                decoration: const BoxDecoration(
                                  color: ColorManager.transparent,
                                ),
                                child: CustomRow(
                                  children: [
                                    CustomExpanded(
                                      child: ContactCardWidget(
                                        contact: contact,
                                      ),
                                    ),
                                    PickedContactIconWidget(index: index,),
                                  ],
                                ),
                              ),
                            );
                          }
                          return CustomSizedBox();
                        },
                      ),
                    ),
                    AddOrRemoveMemberButtonWidget(
                      onTap: (){
                        context.read<GroupCubit>().addOrRemoveContactFromGroup(isAdding: isAdding);
                        navigateAndPop(context);
                      },
                      title: isAdding ? AppStrings.add : AppStrings.remove,
                    ),
                  ],
                );
              },
            )
        );
      },
    );
  }
}
