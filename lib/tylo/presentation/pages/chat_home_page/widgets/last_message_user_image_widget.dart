import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/custom_circle_shape_widget.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/services/shared_preference/shared_prefs_manager.dart';
import 'package:tylo/tylo/presentation/controllers/firestore_controller/fire_store_cubit.dart';
import '../../../../core/components/custom_cached_network_image_widget.dart';
import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../controllers/home_controller/home_cubit.dart';

class LastMessageUserImageWidget extends StatelessWidget {
  const LastMessageUserImageWidget({super.key, required this.imageUrl, required this.sentBy, required this.isSeen, required this.secondUserId, required this.secondUserPhotoVisibility,});
  final String imageUrl;
  final String sentBy;
  final bool isSeen;
  final String secondUserId;
  final String secondUserPhotoVisibility;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Map<String, dynamic> photoVisibility = SharedPrefsManager.getMapData(key: AppStrings.photoVisibility);
    return CustomCircleShapeWidget(
        width: size.width / 8,
        height: size.width / 8,
        borderColor: sentBy != context.read<HomeCubit>().id ?
        isSeen ?
        ColorManager.white.withOpacity(0.2) :
        ColorManager.green.withOpacity(0.7) :
        ColorManager.white.withOpacity(0.2),
        image: ClipOval(
          child: CustomBuilder(
            builder: (context){
              if(imageUrl.isNotEmpty){
                if(secondUserPhotoVisibility == AppStrings.everyone){
                  return CustomCachedNetworkImageWidget(
                    width: size.width / 10,
                    height: size.width / 10,
                    imageUrl: imageUrl,
                    icon: Icons.person,
                  );
                } else{
                  if(photoVisibility[secondUserId] != null && photoVisibility[secondUserId]){
                    if(!context.read<FireStoreCubit>().currentAppUser!.whoBlockMeList.contains(secondUserId)){
                      return CustomCachedNetworkImageWidget(
                        width: size.width / 10,
                        height: size.width / 10,
                        imageUrl: imageUrl,
                        icon: Icons.person,
                      );
                    }
                  }

                }
              }
              return CustomCachedNetworkImageWidget(
                width: size.width / 10,
                height: size.width / 10,
                imageUrl: '',
                icon: Icons.person,
              );
            },
          ),
        )
    );
  }
}
