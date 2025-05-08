import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../../../../core/components/custom_widgets/custom_snack_bar.dart';
import '../../../../core/services/localization/localization.dart';
import '../../../controllers/firestore_controller/fire_store_cubit.dart';
import '../../../../core/components/navigation_button_widget.dart';

class NavigationToProfileImageButtonWidget extends StatelessWidget {
  const NavigationToProfileImageButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationButtonWidget(
        onNavigationState: (){
          final name = context.read<FireStoreCubit>().profileNameController.text.trim();
          if(name.isNotEmpty){
            context.read<FireStoreCubit>().setProfileName(context.read<FireStoreCubit>().profileNameController.text);
          }else{
            CustomToast.show(
              title: translate(context, AppStrings.nameMustNotBeEmpty),
            );
          }
        },
        buttonTitle: AppStrings.next,
    );
  }
}
