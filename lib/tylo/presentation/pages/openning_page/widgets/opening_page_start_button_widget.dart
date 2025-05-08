import 'package:flutter/material.dart';
import '../../../../core/components/custom_widgets/custom_positioned.dart';
import '../../../../core/components/navigation_button_widget.dart';
import '../../../../core/helper_functions/navigator/push_named_remove_until.dart';
import '../../../../core/resources/constants/app_routes.dart';
import '../../../../core/resources/constants/app_strings.dart';

class OpeningPageStartButtonWidget extends StatelessWidget {
  const OpeningPageStartButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return CustomPositioned(
      bottom: size.height / 20,
      right: size.width / 20,
      left: size.width / 20,
      child: NavigationButtonWidget(
        onNavigationState: (){
          pushNamedRemoveUntil(route: AppRoutes.getStartedPage, context: context);
        },
        buttonTitle: AppStrings.start,
      ),
    );
  }
}
