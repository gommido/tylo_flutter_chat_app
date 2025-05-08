import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/navigation_button_widget.dart';
import '../../../../core/resources/constants/app_strings.dart';
import '../../../controllers/contacts_controller/contacts_cubit.dart';

class AddNewContactButtonWidget extends StatelessWidget {
  const AddNewContactButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationButtonWidget(
      onNavigationState: (){
        if(context.read<ContactsCubit>().nameController.text.trim().isNotEmpty && context.read<ContactsCubit>().phoneNumberController.text.trim().isNotEmpty){
          context.read<ContactsCubit>().insertNewContact(
              name: context.read<ContactsCubit>().nameController.text,
              phoneNumber: context.read<ContactsCubit>().phoneNumberController.text
          );
        }
      },
      buttonTitle: AppStrings.add,
    );
  }
}
