
import 'package:flutter/material.dart';

void pushNamed({required String route, required BuildContext context, Object? arguments}){
  Navigator.of(context).pushNamed(route, arguments: arguments);
  print(route);

}