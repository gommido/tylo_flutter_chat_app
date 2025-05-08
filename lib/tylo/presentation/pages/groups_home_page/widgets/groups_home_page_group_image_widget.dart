import 'package:flutter/material.dart';

import '../../../../core/components/custom_cached_network_image_widget.dart';
import '../../../../core/components/custom_circle_shape_widget.dart';
import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/resources/color_manager.dart';

class GroupsHomePageGroupImageWidget extends StatelessWidget {
  const GroupsHomePageGroupImageWidget({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomCircleShapeWidget(
        width: size.width / 8,
        height: size.width / 8,
        borderColor: ColorManager.white.withOpacity(0.2),
        image: CustomBuilder(
          builder: (context){
            if(imageUrl.isNotEmpty){
              return ClipOval(
                child: CustomCachedNetworkImageWidget(
                  width: size.width / 8,
                  height: size.width / 8,
                  imageUrl: imageUrl,
                  icon: Icons.person,
                ),
              );
            }
            return CustomIcon(icon: Icons.person, color: ColorManager.grey,);
          },
        )
    );
  }
}
