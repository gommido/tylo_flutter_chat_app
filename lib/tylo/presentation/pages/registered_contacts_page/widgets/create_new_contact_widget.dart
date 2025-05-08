import 'package:flutter/material.dart';

import '../../../../core/components/custom_circle_shape_widget.dart';
import '../../../../core/components/custom_widgets/custom_column.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/helper_functions/navigator/push_named_navigator.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/constants/app_routes.dart';
import '../../../../core/resources/constants/app_strings.dart';
import '../../../../core/services/localization/localization.dart';

class CreateNewContactWidget extends StatelessWidget {
  const CreateNewContactWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomGestureDetector(
      onTap: (){
        pushNamed(route: AppRoutes.addNewContactPage, context: context);
      },
      child: CustomContainer(
        width: size.width,
        decoration: const BoxDecoration(
          color: ColorManager.transparent,
        ),
        child: CustomColumn(
          children: [
            CustomRow(
              children: [
                CustomCircleShapeWidget(
                  width: size.width / 8,
                  height: size.width / 8,
                  color: ColorManager.primaryColor,
                  image: CustomIcon(
                    icon: Icons.person_add_alt_sharp,
                    color: ColorManager.black,
                  ),
                ),
                CustomSizedBox(width: size.width / 50,),
                CustomText(
                  data: translate(context, AppStrings.newContact),
                  style: Theme.of(context).textTheme.bodyMedium!,
                ),
              ],
            ),
            CustomSizedBox(height: size.height / 50,),
          ],
        ),
      ),
    );
  }
}
