import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_padding.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../controllers/firestore_controller/fire_store_cubit.dart';
import '../../settings_page/widgets/bottom_sheet_bio_widget.dart';
import '../../settings_page/widgets/bottom_sheet_name_widget.dart';

class EditProfileInfoBottomSheetWidget extends StatelessWidget {
  const EditProfileInfoBottomSheetWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomPadding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          CustomContainer(
            height: size.height / 3,
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                colors: [
                  ColorManager.backgroundColor,
                  ColorManager.black,
                ],
              ),
            ),
            padding: const EdgeInsets.all(10),
            child: CustomBuilder(builder: (context){
              if(context.read<FireStoreCubit>().editProfileBottomSheetName != null){
                switch(context.read<FireStoreCubit>().editProfileBottomSheetName){
                  case AppStrings.name:
                    return const BottomSheetNameWidget();
                  case AppStrings.bio:
                    return const BottomSheetBioWidget();
                }
              }
              return CustomSizedBox();
            },
            ),
          ),
        ]
      ),
    );

  }
}
