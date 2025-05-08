import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_gesture_detector.dart';
import 'package:tylo/tylo/core/resources/color_manager.dart';
import 'package:tylo/tylo/presentation/pages/create_new_group_page/widgets/picked_contact_icon_widget.dart';
import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_expanded.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../domain/entities/app_contact.dart';
import '../../../controllers/group_controller/group_cubit.dart';
import '../../registered_contacts_page/widgets/contact_card_widget.dart';

class PickGroupContactsWidget extends StatelessWidget {
  const PickGroupContactsWidget({super.key, required this.contact, required this.index});
  final AppContact contact;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<GroupCubit, GroupState>(
      listener: (context, state) {},
      builder: (context, state) {
        final size = MediaQuery.of(context).size;

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
              padding: const EdgeInsets.all(8.0),
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
            )
        );
      },
    );
  }
}