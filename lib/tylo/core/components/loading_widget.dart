import 'package:flutter/material.dart';

import 'custom_widgets/custom_center.dart';
import 'custom_widgets/custom_sized_box.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomCenter(
      child: CustomSizedBox(
        height: 15, width: 15,
        child: CircularProgressIndicator(
          color: color,
          strokeWidth: 1,
        ),
      ),
    );
  }
}
