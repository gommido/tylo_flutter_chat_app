import 'package:flutter/material.dart';

import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/resources/constants/app_constants.dart';

class AppBarLogoWidget extends StatelessWidget {
  const AppBarLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomContainer(
      width: size.width / 5,
      height: size.height / 10,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(appLogoWhite),
        ),
      ),
    );
  }
}
