import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_internet_checker.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import '../../../../core/helper_functions/navigator/push_named_navigator.dart';
import '../../../../core/resources/constants/app_routes.dart';
import '../../../controllers/auth_controller/auth_cubit.dart';
import '../../../../core/components/navigation_button_widget.dart';

class NavigationToOtpPageButtonWidget extends StatelessWidget {
  const NavigationToOtpPageButtonWidget({super.key});


  @override
  Widget build(BuildContext context) {
    return NavigationButtonWidget(
        onNavigationState: (){
          final phoneNumber = context.read<AuthCubit>().phoneController.text.trim();
          CustomInternetChecker.checkInternetAvailability(
              context: context,
              onInternetAvailable: (){
                if(phoneNumber.isNotEmpty && phoneNumber.length >= 10){
                  context.read<AuthCubit>().signUpWithPhoneNumber();
                  pushNamed(route: AppRoutes.otpVerificationPage, context: context);
                }
              },
          );
        },
        buttonTitle: AppStrings.next,
    );
  }
}

