import 'package:flutter/material.dart';
import 'package:tylo/tylo/domain/entities/call.dart';

import '../../../../core/components/custom_cached_network_image_widget.dart';
import '../../../../core/components/custom_circle_shape_widget.dart';
import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/constants/app_strings.dart';
import '../../../../core/services/shared_preference/shared_prefs_manager.dart';

class CallerImageWidget extends StatelessWidget {
  const CallerImageWidget({super.key, required this.call});
  final Call call;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomBuilder(
        builder: (context) {
          Map<String, dynamic> photoVisibility = SharedPrefsManager.getMapData(key: AppStrings.photoVisibility);
          if(photoVisibility[call.secondUserId]){
            return CustomCircleShapeWidget(
                width: size.width / 8,
                height: size.width / 8,
                image: CustomBuilder(
                  builder: (context){
                    if(call.secondUserImage.isNotEmpty){
                      return ClipOval(
                        child: CustomCachedNetworkImageWidget(
                          width: size.width / 10,
                          height: size.width / 10,
                          imageUrl: call.secondUserImage,
                          icon: Icons.person,
                        ),
                      );
                    }
                    return CustomIcon(icon: Icons.person, color: ColorManager.white,);
                  },
                )
            );
          }
          return CustomCircleShapeWidget(
            width: size.width / 8,
            height: size.width / 8,
            image: CustomBuilder(
              builder: (context){
                if(call.secondUserImage.isNotEmpty){
                  return ClipOval(
                    child: CustomCachedNetworkImageWidget(
                      width: size.width / 10,
                      height: size.width / 10,
                      imageUrl: '',
                      icon: Icons.person,
                    ),
                  );
                }
                return CustomIcon(icon: Icons.person, color: ColorManager.white,);
              },
            ),
          );

        }
    );
  }
}
