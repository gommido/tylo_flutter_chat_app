import 'package:flutter/material.dart';

import '../../../../core/components/custom_cached_network_image_widget.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/resources/color_manager.dart';

class ImageMessageWidget extends StatelessWidget {
  const ImageMessageWidget({super.key, required this.messageText});
  final String messageText;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomContainer(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          color: ColorManager.primaryColor.withOpacity(0.5),
        ),
      ),
      child: CustomCachedNetworkImageWidget(
        imageUrl: messageText,
        height: size.height / 2.5,
        width: size.width / 2,
        icon: Icons.image_not_supported_outlined,
      ),
    );
  }
}
