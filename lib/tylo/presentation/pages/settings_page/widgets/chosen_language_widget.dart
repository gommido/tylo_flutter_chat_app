import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/services/shared_preference/shared_prefs_manager.dart';
import '../../../controllers/home_controller/home_cubit.dart';

class ChosenLanguageWidget extends StatelessWidget {
  const ChosenLanguageWidget({super.key, required this.language});
  final Map<String, dynamic> language;

  @override
  Widget build(BuildContext context) {
    return CustomBuilder(
      builder: (context){
        if((context.read<HomeCubit>().currentLanguage != null &&
            context.read<HomeCubit>().currentLanguage == language[AppStrings.tag])
            || SharedPrefsManager.getStringData(key: AppStrings.language) == language[AppStrings.tag]){
          return  CustomIcon(
            icon: Icons.done,
            color: ColorManager.green,
          );
        }
        return CustomSizedBox();
      },
    );
  }
}
