import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import '../../../../core/components/navigation_button_widget.dart';
import '../../../../core/helper_functions/navigator/push_named_navigator.dart';
import '../../../../core/resources/constants/app_routes.dart';

class ContinueWithPhoneButtonWidget extends StatelessWidget {
  const ContinueWithPhoneButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationButtonWidget(
      onNavigationState: (){
        pushNamed(route: AppRoutes.phoneSignUpPage, context: context);
      },
      buttonTitle: AppStrings.signUp,
    );
  }
}
