import 'package:flutter/material.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({super.key, required this.itemCount, required this.itemBuilder, required this.scrollPhysics});
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final ScrollPhysics scrollPhysics;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,

      ),
      shrinkWrap: true,
      physics: scrollPhysics,
      padding: EdgeInsets.zero,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
