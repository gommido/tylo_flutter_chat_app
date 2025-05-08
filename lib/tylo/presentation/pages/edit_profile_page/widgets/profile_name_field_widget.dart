import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/presentation/pages/edit_profile_page/widgets/user_data_field_widget.dart';

import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/custom_widgets/custom_padding.dart';
import '../../../../core/services/localization/localization.dart';
import '../../../controllers/firestore_controller/fire_store_cubit.dart';
import 'edit_profile_info_bottom_sheet_widget.dart';

class ProfileNameFieldWidget extends StatelessWidget {
  const ProfileNameFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomGestureDetector(
      onTap: (){
        context.read<FireStoreCubit>().setEditProfileBottomSheetName(AppStrings.name);
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (builder){
              return const EditProfileInfoBottomSheetWidget();
            }
        );
      },
      child: CustomPadding(
        padding: const EdgeInsets.all(8.0),
        child: UserDataFieldWidget(
          fieldName: translate(context, AppStrings.name),
          fieldValue: context.watch<FireStoreCubit>().currentAppUser!.name,
          icon: Icons.edit,
        )
      ),
    );
  }
}
