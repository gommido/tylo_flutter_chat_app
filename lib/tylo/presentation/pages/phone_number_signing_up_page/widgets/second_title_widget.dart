import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/bloc_consumer_widget.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_sized_box.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/resources/font_manager.dart';
import 'package:tylo/tylo/presentation/controllers/auth_controller/auth_cubit.dart';

import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/services/localization/localization.dart';

class SecondTitleWidget extends StatelessWidget {
  const SecondTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<AuthCubit, AuthState>(
        listener: (context, state){},
        builder: (context, state){
          if(context.watch<AuthCubit>().phoneController.text.startsWith('0')){
            return CustomText(
              data: translate(context, AppStrings.pleaseRemove0),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: ColorManager.grey,
                fontSize: FontManager.s10,
              ),
            );
          }
          return CustomSizedBox();

        });
  }
}
