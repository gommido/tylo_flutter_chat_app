import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/presentation/pages/privacy_page/widgets/photo_visibility_title_widget.dart';

import '../../../../core/components/bloc_consumer_widget.dart';
import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/helper_functions/navigator/push_named_navigator.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/constants/app_routes.dart';
import '../../../controllers/firestore_controller/fire_store_cubit.dart';

class ProfilePhotoVisibility extends StatelessWidget {
  const ProfilePhotoVisibility({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomGestureDetector(
      onTap: (){
        pushNamed(route: AppRoutes.photoVisibilityPage, context: context);

      },
      child: CustomContainer(
        width: size.width,
        decoration: const BoxDecoration(
          color: ColorManager.transparent,
        ),
        child: CustomColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PhotoVisibilityTitleWidget(),
            BlocConsumerWidget<FireStoreCubit, FireStoreState>(
              listener: (context, state){},
              builder: (context, state){
                return CustomText(
                  data: context.watch<FireStoreCubit>().currentAppUser!.photoVisibility,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: ColorManager.grey,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
