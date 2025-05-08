import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_builder.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_sized_box.dart';
import 'custom_cached_network_image_widget.dart';
import 'custom_widgets/custom_container.dart';
import 'custom_widgets/custom_stack.dart';
import '../resources/color_manager.dart';

class VideoFileMessageThumbnailWidget extends StatelessWidget {
  VideoFileMessageThumbnailWidget({super.key, required this.videoMessageThumbnail, required this.messageText, this.imageUploadingProgress,});
  final String videoMessageThumbnail;
  final String messageText;
  int? imageUploadingProgress;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomContainer(
        alignment: Alignment.center,
        height: size.height / 2.5,
        width: size.width / 2,
        decoration: BoxDecoration(
          color: ColorManager.black,
          border: Border.all(
              color: ColorManager.primaryColor.withOpacity(0.2)
          ),
        ),
        child: CustomStack(
          alignment: Alignment.center,
          children: [
            CustomCachedNetworkImageWidget(
              imageUrl: videoMessageThumbnail,
              height: size.height / 2.5,
              width: size.width / 2,
              icon: Icons.image,
            ),
            CustomBuilder(
              builder: (context){
                if(messageText.isEmpty){
                  return CircularPercentIndicator(
                    radius: size.width / 20,
                    backgroundColor: ColorManager.white,
                    percent: imageUploadingProgress != null ? (imageUploadingProgress! / 9.toDouble()) : 0.0,
                    progressColor: ColorManager.green,
                    lineWidth: size.width / 200,
                  );
                }
                return CustomSizedBox();
              },
            ),
          ],
        )
    );

  }
}
