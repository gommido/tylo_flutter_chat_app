import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/core/components/bloc_consumer_widget.dart';

import '../../../../core/components/custom_cached_network_image_widget.dart';
import '../../../../core/components/custom_circle_shape_widget.dart';
import '../../../../core/components/custom_widgets/custom_container.dart';
import '../../../../core/components/custom_widgets/custom_stack.dart';
import '../../../controllers/firestore_controller/fire_store_cubit.dart';
import '../../calls_home_page/widgets/glowoing_call_widget.dart';

class CallReceiverImageWidget extends StatelessWidget {
  const CallReceiverImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumerWidget<FireStoreCubit, FireStoreState>(
        listener: (context, state){},
        builder: (context, state){
          return CustomContainer(
            width: size.width / 2,
            height: size.width / 2,
            child: CustomStack(
              alignment: Alignment.center,
              children: [
                AnimatedGlowingContainer(
                  width: size.width / 1.5,
                  height: size.width / 1.5,
                  shape: BoxShape.circle,
                ),
                CustomCircleShapeWidget(
                  width: size.width / 2.5,
                  height: size.width / 2.5,
                  image: ClipOval(
                    child:  CustomCachedNetworkImageWidget(
                      width: size.width / 2.5,
                      height: size.width / 2.5,
                      imageUrl: context.read<FireStoreCubit>().streamAppUser!.photo,
                      icon: Icons.person,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
    );
  }
}
