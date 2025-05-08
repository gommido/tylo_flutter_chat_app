import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PopScope customPopScope({
  required void Function(bool)? onPopInvoked,
  required Widget child,
  bool canPop = true,
}){
  return PopScope(
    onPopInvoked: onPopInvoked,
    canPop: canPop,
    child: child,
  );
}