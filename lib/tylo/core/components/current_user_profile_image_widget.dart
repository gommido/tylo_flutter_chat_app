import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/bloc_consumer_widget.dart';

import '../../presentation/controllers/firestore_controller/fire_store_cubit.dart';
import '../resources/color_manager.dart';
import 'custom_cached_network_image_widget.dart';
import 'custom_circle_shape_widget.dart';
import 'custom_widgets/custom_icon.dart';

class CurrentUserProfileImageWidget extends StatelessWidget {
  const CurrentUserProfileImageWidget({super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return BlocConsumerWidget<FireStoreCubit, FireStoreState>(
        listener: (context, state){},
        builder: (context, state){
          if(context.watch<FireStoreCubit>().currentAppUser!.photo.isNotEmpty){
            return CustomCircleShapeWidget(
              width: width,
              height: height,
              image: ClipOval(
                child: CustomCachedNetworkImageWidget(
                  width: width,
                  height: height,
                  imageUrl: context.read<FireStoreCubit>().currentAppUser!.photo,
                  icon: Icons.person,
                ),
              ),
            );
          }
          return CustomIcon(icon: Icons.person, color: ColorManager.grey,);
        },
    );
  }
}
