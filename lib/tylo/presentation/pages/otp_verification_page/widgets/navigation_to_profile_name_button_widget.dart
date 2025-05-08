import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/navigation_button_widget.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import '../../../../core/components/custom_widgets/custom_internet_checker.dart';
import '../../../../core/components/custom_widgets/custom_snack_bar.dart';
import '../../../../core/services/localization/localization.dart';
import '../../../controllers/auth_controller/auth_cubit.dart';

class NavigationToProfileNameButtonWidget extends StatelessWidget {
  const NavigationToProfileNameButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationButtonWidget(
        onNavigationState: (){
          CustomInternetChecker.checkInternetAvailability(
            context: context,
            onInternetAvailable: (){
              if(context.read<AuthCubit>().pinCode != null){
                if(context.read<AuthCubit>().pinCode!.isNotEmpty &&
                    context.read<AuthCubit>().pinCode!.length == 6){
                  context.read<AuthCubit>().verifyPhoneNumber();
                }
                else if(context.read<AuthCubit>().pinCode != null && context.read<AuthCubit>().pinCode!.length < 6){
                  CustomToast.show(
                    title: translate(context, AppStrings.pinCodeNotComplete),
                  );
                }
              }else{
                CustomToast.show(
                  title: translate(context, AppStrings.enterPinCod),
                );
              }
            },
          );

        },
        buttonTitle: AppStrings.verifyNumber,
    );
  }
}
