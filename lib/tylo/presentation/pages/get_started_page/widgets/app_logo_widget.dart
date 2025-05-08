import 'package:flutter/material.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/resources/constants/app_constants.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomContainer(
      width: size.width / 2,
      height: size.height / 4,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(appLogoWhite),
        ),
      ),
    );
  }
}
