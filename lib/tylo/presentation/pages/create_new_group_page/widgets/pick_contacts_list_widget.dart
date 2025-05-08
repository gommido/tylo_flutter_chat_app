import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_list_view_widget.dart';
import 'package:tylo/tylo/presentation/controllers/local_storage_controller/local_storage_cubit.dart';
import 'package:tylo/tylo/presentation/pages/create_new_group_page/widgets/pick_group_contacts_widget.dart';

import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_expanded.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../controllers/group_controller/group_cubit.dart';

class PickContactsListWidget extends StatelessWidget {
  const PickContactsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomExpanded(
      child:  CustomContainer(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          border: Border.all(color: ColorManager.primaryColor.withOpacity(0.1)),
        ),
        child: Scrollbar(
          child: BlocConsumerWidget<LocalStorageCubit, LocalStorageState>(
            listener: (context, state){},
            builder: (context, state){
              if(context.read<LocalStorageCubit>().storedRegisteredContacts.isEmpty){
                return CustomSizedBox();
              }
              return CustomListViewWidget(
                itemCount: context.read<LocalStorageCubit>().storedRegisteredContacts.length,
                separatorBuilder: (context, index) =>  CustomSizedBox(height: size.height / 50,),
                itemBuilder: (context, index) {
                  final contact = context.read<LocalStorageCubit>().storedRegisteredContacts[index];
                  context.read<GroupCubit>().isContactPicked.add(false);
                  return PickGroupContactsWidget(
                    contact: contact,
                    index: index,
                  );
                },
              );
            },
          ),
        ),
      ),
    );

  }
}
