import 'package:flutter/material.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/resources/constants/app_constants.dart';

class OpeningPageGifWidget extends StatelessWidget {
  const OpeningPageGifWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomContainer(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(openingPageGif),
          fit: BoxFit.cover,
          opacity: 0.5,
        ),
      ),
    );
  }
}
