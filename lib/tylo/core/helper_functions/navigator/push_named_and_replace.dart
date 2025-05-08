
import 'package:flutter/material.dart';

void pushNamedAndReplace({required String route, required BuildContext context, Object? arguments}) {
  Navigator.of(context).pushReplacementNamed(route, arguments: arguments);
}