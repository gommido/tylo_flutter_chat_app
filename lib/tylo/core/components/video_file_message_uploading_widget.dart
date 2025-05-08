import 'dart:io';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'custom_widgets/custom_container.dart';
import '../resources/color_manager.dart';

class VideoFileMessageUploadingWidget extends StatelessWidget {
  VideoFileMessageUploadingWidget({super.key, required this.videoThumbnail, this.imageUploadingProgress,});
  final String videoThumbnail;
  int? imageUploadingProgress;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomContainer(
      alignment: AlignmentDirectional.center,
      height: size.height / 2.5,
      width: size.width / 2,
      decoration: BoxDecoration(
        color: ColorManager.black,
        border: Border.all(
            color: ColorManager.primaryColor.withOpacity(0.2)
        ),
        image: DecorationImage(
          image: FileImage(File(videoThumbnail)),
          fit: BoxFit.cover,
        ),
      ),
      child: CircularPercentIndicator(
        radius: size.width / 20,
        backgroundColor: ColorManager.white,
        percent: imageUploadingProgress != null ?
        (imageUploadingProgress! / 10.toDouble()) : 0.0,
        progressColor: ColorManager.green,
        lineWidth: size.width / 200,
      ),
    );

  }
}
