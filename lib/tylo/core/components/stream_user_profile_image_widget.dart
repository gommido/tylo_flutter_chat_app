import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/bloc_consumer_widget.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_builder.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import '../../presentation/controllers/firestore_controller/fire_store_cubit.dart';
import '../services/shared_preference/shared_prefs_manager.dart';
import 'custom_cached_network_image_widget.dart';
import 'custom_circle_shape_widget.dart';

class StreamUserProfileImageWidget extends StatelessWidget {
  const StreamUserProfileImageWidget({super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<FireStoreCubit, FireStoreState>(
      listener: (context, state){},
      builder: (context, state){
        final user = context.read<FireStoreCubit>().streamAppUser!;
        return CustomCircleShapeWidget(
          width: width,
          height: height,
          image: ClipOval(
            child: CustomBuilder(
              builder: (context){
                if(user.photo.isNotEmpty){
                  if(!context.read<FireStoreCubit>().currentAppUser!.whoBlockMeList.contains(user.id)){
                    if(!context.read<FireStoreCubit>().currentAppUser!.whoBlockMeList.contains(user.id)){
                      if(user.photoVisibility == AppStrings.everyone){
                        return CustomCachedNetworkImageWidget(
                          width: width,
                          height: height,
                          imageUrl: context.read<FireStoreCubit>().streamAppUser!.photo,
                          icon: Icons.person,
                        );
                      }else{
                        Map<String, dynamic> photoVisibility = SharedPrefsManager.getMapData(key: AppStrings.photoVisibility);
                        if(photoVisibility[user.id] != null && photoVisibility[user.id]){
                          return CustomCachedNetworkImageWidget(
                            width: width,
                            height: height,
                            imageUrl: context.read<FireStoreCubit>().streamAppUser!.photo,
                            icon: Icons.person,
                          );
                        }
                      }
                    }
                  }
                }
                return CustomCachedNetworkImageWidget(
                  width: width,
                  height: height,
                  imageUrl: '',
                  icon: Icons.person,
                );
              },
            ),
          ),
        );
      },
    );

  }
}
