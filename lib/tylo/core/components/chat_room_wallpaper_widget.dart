import 'package:flutter/material.dart';

import '../resources/constants/app_constants.dart';
import 'custom_widgets/custom_container.dart';
import 'custom_widgets/custom_expanded.dart';

class ChatRoomWallpaperWidget extends StatelessWidget {
  const ChatRoomWallpaperWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomExpanded(
      child: CustomContainer(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(chatRoomWallpaper),
              fit: BoxFit.cover,
              opacity: 0.1,
            )
        ),
        child: child,
      ),
    );
  }
}
