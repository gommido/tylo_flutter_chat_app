import 'package:flutter/material.dart';

class CustomListViewWidget extends StatelessWidget {
  CustomListViewWidget({super.key, required this.itemCount, required this.separatorBuilder, required this.itemBuilder, this.controller, this.scrollDirection , this.physics, this.shrinkWrap});
  final int itemCount;
  final Widget Function(BuildContext, int) separatorBuilder;
  final Widget Function(BuildContext, int) itemBuilder;
  ScrollController? controller;
  Axis? scrollDirection;
  bool? shrinkWrap;
  ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: controller,
      shrinkWrap: shrinkWrap != null ? shrinkWrap! : false,
      physics: physics,
      scrollDirection: scrollDirection != null ? scrollDirection! : Axis.vertical,
      itemCount: itemCount,
      separatorBuilder: separatorBuilder,
      itemBuilder: itemBuilder,
    );
  }
}
