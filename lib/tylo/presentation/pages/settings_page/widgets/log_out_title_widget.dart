import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/helper_functions/navigator/push_named_remove_until.dart';
import 'package:tylo/tylo/core/resources/constants/app_routes.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/resources/constants/firebase_constants.dart';
import 'package:tylo/tylo/core/services/shared_preference/shared_prefs_manager.dart';
import 'package:tylo/tylo/presentation/controllers/firestore_controller/fire_store_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/home_controller/home_cubit.dart';

import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/services/localization/localization.dart';

class LogOutTitleWidget extends StatelessWidget {
  const LogOutTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomGestureDetector(
      onTap: (){
        context.read<HomeCubit>().onLogOutLoading().then((value){
          SharedPrefsManager.saveBoolData(key: AppStrings.isCreated, value: false).then((value){
            pushNamedRemoveUntil(route: AppRoutes.getStartedPage, context: context);
            context.read<HomeCubit>().setCurrentIndexData();
            context.read<FireStoreCubit>().updateAppUserData(
              id: context.read<HomeCubit>().id,
              field: FireBaseConstants.lastSeen,
              value: Timestamp.now(),
            );
          });
        });
      },
      child: CustomContainer(
        width: size.width,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: ColorManager.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: CustomRow(
          children: [
            CustomIcon(
              icon: Icons.logout,
              color: ColorManager.grey,
            ),
            CustomSizedBox(width: size.width / 50,),
            CustomText(
              data: translate(context, AppStrings.logOut),
              style: Theme.of(context).textTheme.bodyMedium!,
            ),
          ],
        ),
      ),
    );
  }
}
