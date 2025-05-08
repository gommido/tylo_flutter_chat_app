
import 'package:flutter/material.dart';
import '../../../../core/components/custom_widgets/custom_icon.dart';
import '../../../../core/resources/color_manager.dart';

class CallDialerIconWidget extends StatelessWidget {
  const CallDialerIconWidget({super.key, required this.isDialed});
  final bool isDialed;

  @override
  Widget build(BuildContext context) {
    return CustomIcon(
      icon: isDialed ? Icons.call_made_rounded : Icons.call_received_rounded,
      color: isDialed ? ColorManager.green : ColorManager.red,
    );
  }
}
