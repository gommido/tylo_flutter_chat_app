import 'package:flutter/material.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_positioned.dart';
import '../../../../core/resources/constants/app_constants.dart';

class OpeningPageAppLogoWidget extends StatelessWidget {
  const OpeningPageAppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomPositioned(
      bottom: size.height / 5,
      right: 0,
      left: 0,
      child: CustomContainer(
        width: size.width / 4,
        height: size.height / 8,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(appLogoWhite),
          ),
        ),
      ),
    );
  }
}
