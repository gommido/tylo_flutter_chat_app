import 'package:flutter/material.dart';

import '../../../../core/components/custom_interaction_icon_widget.dart';
import '../../../../core/components/custom_widgets/custom_expanded.dart';
import '../../../../core/components/custom_widgets/custom_gesture_detector.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/helper_functions/make_video_call.dart';
import '../../../../core/helper_functions/navigator/navigator_pop.dart';
import '../../../../core/resources/constants/app_strings.dart';
import '../../../../core/services/localization/localization.dart';

class InteractionWithContactWidget extends StatelessWidget {
  const InteractionWithContactWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomRow(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomExpanded(
          child: CustomGestureDetector(
            onTap: (){
              navigateAndPop(context);
            },
            child: CustomInteractionIconWidget(
              title: translate(context, AppStrings.chatC),
              icon: Icons.message,
            ),
          ),
        ),

        CustomSizedBox(width: size.width / 25,),
        CustomExpanded(
          child: CustomGestureDetector(
            onTap: ()=> makeVideoCall(context: context,),
            child: CustomInteractionIconWidget(
              title: translate(context, AppStrings.videoCall),
              icon: Icons.video_camera_back_rounded,
            ),
          ),
        ),
      ],
    );
  }
}
