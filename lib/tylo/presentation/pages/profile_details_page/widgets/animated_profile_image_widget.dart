import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tylo/tylo/presentation/controllers/firestore_controller/fire_store_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/group_controller/group_cubit.dart';
import 'package:tylo/tylo/presentation/controllers/user_profile_controller/user_profile_cubit.dart';

import '../../../../core/components/current_user_profile_image_widget.dart';
import '../../../../core/components/custom_circle_shape_widget.dart';
import '../../../../core/components/custom_file_image_widget.dart';
import '../../../../core/resources/color_manager.dart';

class AnimatedCircleBehindContainer extends StatefulWidget {
  const AnimatedCircleBehindContainer({super.key, });

  @override
  State<AnimatedCircleBehindContainer> createState() => _AnimatedCircleBehindContainerState();
}

class _AnimatedCircleBehindContainerState extends State<AnimatedCircleBehindContainer> {
  // Initial bottom offset to start from bottom to top animation
  double _bottomPosition = -50; // Adjust based on your CircleImage size

  @override
  void initState() {
    super.initState();
    // Wait for 2 seconds before starting the animation
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        // Move the CircleImage to make it visible and animate from bottom to top
        _bottomPosition = 20; // Adjust this value based on the desired end position
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRect(
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                bottom: _bottomPosition,
                left: (size.width / 3.3) - (size.width / 20),
                child: Stack(
                  children: [
                    CustomCircleShapeWidget(
                      width: size.width / 2,
                      height: size.width / 2,
                      image: CurrentUserProfileImageWidget(
                        width: size.width / 2,
                        height: size.width / 2,
                      ),
                    ),
                    Positioned(
                      left: 0, top: 0,
                      child: Visibility(
                        visible: context.watch<UserProfileCubit>().isVisible,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: ColorManager.black,
                          child: IconButton(
                              onPressed: (){},
                              icon: const Icon(Icons.camera_alt, size: 35,)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

