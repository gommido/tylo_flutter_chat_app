import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../arrow_back_icon.dart';
import 'custom_icon_button.dart';


PreferredSizeWidget customAppBar({
  required BuildContext context,
  Widget? title,
  VoidCallback? onPressed,
  List<Widget>? actions,
  TabBar? bottom,
  bool isLeadingIconShown = true,
  bool centerTitle = true,
  Color? backgroundColor,
}){
  return AppBar(
    backgroundColor: backgroundColor ?? Theme.of(context).appBarTheme.backgroundColor,
    centerTitle: centerTitle,
    title: title,
    leading: isLeadingIconShown ?
    CustomIconButton(
      onPressed: onPressed!,
      icon: const ArrowBackIcon(),
    ) : null,
    actions: actions,
    bottom: bottom,
  );
}

