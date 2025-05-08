import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:tylo/tylo/core/resources/color_manager.dart';
import 'custom_circle_shape_widget.dart';
import 'custom_widgets/custom_builder.dart';
import 'custom_widgets/custom_icon.dart';

class CustomFileImageWidget extends StatelessWidget {
  const CustomFileImageWidget({super.key, required this.imagePath, required this.width, required this.height });
  final double width;
  final double height;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return CustomCircleShapeWidget(
      width: width,
      height: height,
      image: CustomBuilder(
        builder: (context){
          if(imagePath.isEmpty){
            return CustomIcon(icon: Icons.camera_alt, color: ColorManager.grey,);
          }
          return ClipOval(
              child: Image(
                image: FileImage(File(imagePath),),
                fit: BoxFit.cover,
                width: width,
                height: height,
              ),
          );
        },
      ),
    );
  }
}
