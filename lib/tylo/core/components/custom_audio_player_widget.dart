import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_gesture_detector.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_stack.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import 'custom_cached_network_image_widget.dart';
import 'custom_circle_shape_widget.dart';
import 'custom_widgets/custom_builder.dart';
import 'custom_widgets/custom_column.dart';
import 'custom_widgets/custom_container.dart';
import 'custom_widgets/custom_expanded.dart';
import 'custom_widgets/custom_icon.dart';
import 'custom_widgets/custom_row.dart';
import 'custom_widgets/custom_sized_box.dart';
import 'custom_widgets/custom_text.dart';
import 'loading_widget.dart';

class CustomAudioPlayerWidget extends StatelessWidget {
  const CustomAudioPlayerWidget({super.key, required this.width, required this.height, required this.audioPath, required this.onTap, required this.icon, required this.max, required this.value, this.onChanged, required this.duration, required this.position, required this.isLoading, required this.isMessage, required this.senderImage});
  final double width;
  final double height;
  final String audioPath;
  final Function() onTap;
  final IconData icon;
  final double max;
  final double value;
  final Function(double)? onChanged;
  final String duration;
  final String position;
  final bool isLoading;
  final bool isMessage;
  final String senderImage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomContainer(
      alignment: Alignment.center,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: ColorManager.voiceNoteBg,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: ColorManager.white.withOpacity(0.1),
        )
      ),
      child: CustomColumn(
        children: [
          CustomRow(
            children: [
              CustomSizedBox(width: size.width / 50,),
              CustomGestureDetector(
                onTap: onTap,
                child: CustomStack(
                  alignment: Alignment.center,
                  children: [
                    CustomCircleShapeWidget(
                      width: size.width / 12,
                      height: size.width / 12,
                      image: CustomBuilder(
                        builder: (context){
                          if(isMessage){
                            if(senderImage.isNotEmpty){
                              return ClipOval(
                                child: CustomCachedNetworkImageWidget(
                                  width: size.width / 10,
                                  height: size.width / 10,
                                  imageUrl: senderImage,
                                  icon: Icons.person,
                                ),
                              );
                            }
                          }
                          return CustomIcon(icon: Icons.person, color: ColorManager.grey,);
                        },
                      ),
                    ),

                    CustomBuilder(
                      builder: (context){
                        if(audioPath.isEmpty){
                          return const LoadingWidget(color: ColorManager.white);
                        }
                        return CustomBuilder(
                          builder: (context){
                            if(isLoading){
                              return const LoadingWidget(color: ColorManager.white);
                            }
                            return CustomIcon(
                              icon: icon,
                              color: ColorManager.white.withOpacity(0.5),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              CustomExpanded(
                child: Slider(
                  thumbColor: ColorManager.transparent,
                  activeColor: ColorManager.primaryColor,
                  min: 0,
                  max: max,
                  value: value,
                  onChanged: onChanged,
                ),
              )
            ],
          ),
          CustomRow(
            children: [
              CustomSizedBox(width: size.width / 5,),
              CustomText(
                data: position,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: FontManager.s08,
                ),
              ),
              const Spacer(),
              CustomText(
                data: duration,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: FontManager.s08,
                ),
              ),
              CustomSizedBox(width: size.width / 20,),
            ],
          )
        ],
      ),


    );
  }
}