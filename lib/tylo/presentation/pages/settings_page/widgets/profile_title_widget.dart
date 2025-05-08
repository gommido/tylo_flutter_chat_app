import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/helper_functions/navigator/push_named_navigator.dart';
import 'package:tylo/tylo/core/resources/constants/app_routes.dart';
import '../../../../core/components/current_user_profile_image_widget.dart';
import '../../../../core/components/custom_circle_shape_widget.dart';
import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/helper_functions/capitalize_all_words.dart';
import '../../../../core/helper_functions/detect_language.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../controllers/firestore_controller/fire_store_cubit.dart';

class ProfileTitleWidget extends StatelessWidget {
  const ProfileTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomGestureDetector(
      onTap: (){
        pushNamed(route: AppRoutes.editProfilePage, context: context);
      },
      child: CustomContainer(
        width: size.width,
        decoration: const BoxDecoration(
          color: ColorManager.transparent,
        ),
        child: CustomRow(
          children: [
            CustomCircleShapeWidget(
                image: CurrentUserProfileImageWidget(
                  width: size.width / 9,
                  height: size.width / 9,
                ),
              width: size.width / 9,
              height: size.width / 9,
            ),
            CustomSizedBox(width: size.width / 50,),
            CustomColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomBuilder(
                  builder: (context) {
                    final name = context.read<FireStoreCubit>().currentAppUser!.name;
                    final isLatinWord = detectWordLanguage(name);
                    return CustomText(
                      data: isLatinWord ? capitalizeAllWords(name) : name,
                      style: Theme.of(context).textTheme.bodyMedium!,
                    );
                  }
                ),
                CustomText(
                  data: context.read<FireStoreCubit>().currentAppUser!.bio,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: ColorManager.grey,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
