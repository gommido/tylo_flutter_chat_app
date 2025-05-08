import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../resources/color_manager.dart';
import 'custom_widgets/custom_icon.dart';
import 'loading_widget.dart';

class CustomCachedNetworkImageWidget extends StatelessWidget {
  const CustomCachedNetworkImageWidget({super.key, required this.imageUrl, required this.icon, required this.width, required this.height});
  final double width;
  final double height;
  final String imageUrl;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: imageUrl,
      placeholder: (context, url) => const LoadingWidget(color: ColorManager.white),
      errorWidget: (context, url, error) => CustomIcon(icon: icon, color: ColorManager.grey, size: 25,),
      fit: BoxFit.cover,
    );
  }
}
