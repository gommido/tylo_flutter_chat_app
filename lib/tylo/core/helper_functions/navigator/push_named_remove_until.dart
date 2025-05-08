
import 'package:flutter/material.dart';

void pushNamedRemoveUntil({required String route, required BuildContext context, Object? arguments}){
  Navigator.of(context).pushNamedAndRemoveUntil(
      route, (route) => false, arguments: arguments);
}