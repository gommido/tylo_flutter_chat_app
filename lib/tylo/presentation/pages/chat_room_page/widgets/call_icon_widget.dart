import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_internet_checker.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/localization/localization.dart';
import '../../../../core/components/custom_speed_dial.dart';
import '../../../../core/components/custom_widgets/custom_circle_avatar.dart';
import '../../../../core/components/custom_widgets/custom_speed_dial_child.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/helper_functions/make_video_call.dart';
import '../../../../core/resources/color_manager.dart';


class CallIconWidget extends StatelessWidget {
  const CallIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCircleAvatar(
      radius: 15,
      backgroundColor: ColorManager.green,
      child: CustomSpeedDial(
        isBottom: false,
        icon: Icons.call,
        children: [
          customSpeedDialChild(
            context: context,
            icon: Icons.video_call_sharp,
            label: CustomText(
              data: translate(context, AppStrings.videoCall),
              style: Theme.of(context).textTheme.bodySmall!,),
            onTap: (){
              CustomInternetChecker.checkInternetAvailability(
                  context: context,
                  onInternetAvailable: ()=> makeVideoCall(context: context),
              );
            },
          ),
        ],
      ),
    );
  }
}
