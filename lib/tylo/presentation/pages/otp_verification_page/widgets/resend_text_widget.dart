import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/presentation/controllers/auth_controller/auth_cubit.dart';

import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/components/custom_widgets/custom_text_button.dart';
import '../../../../core/helper_functions/format_time.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/services/localization/localization.dart';

class ResendTextWidget extends StatelessWidget {
  const ResendTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<AuthCubit, AuthState>(
      listener: (context, state){},
      builder: (context, state){
        return CustomTextButton(
          onPressed: (){
            context.read<AuthCubit>().signUpWithPhoneNumber();
          },
          child: CustomBuilder(
            builder: (context){
              if(context.read<AuthCubit>().timing != 0){
                return CustomText(
                  data: formatTime(context.watch<AuthCubit>().timing).toString(),
                  style: Theme.of(context).textTheme.bodySmall!,);
              }else{
                return CustomText(
                  data: translate(context, AppStrings.resend),
                  style:Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: ColorManager.white,
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
