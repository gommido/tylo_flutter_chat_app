import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet{
  static void showBottomSheet({
    required BuildContext context,
    Color? backgroundColor ,
    required Widget child,
  }){
    showModalBottomSheet(
        backgroundColor: backgroundColor ?? Theme.of(context).bottomSheetTheme.backgroundColor,
        context: context,
        builder: (context) {
          return child;
        });
  }
}