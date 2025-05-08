import 'package:flutter/material.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/helper_functions/format_call_duration.dart';
import '../../../../core/resources/font_manager.dart';

class CallDurationWidget extends StatelessWidget {
  const CallDurationWidget({super.key, required this.duration,});
  final int duration;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      data: formatCallDuration(duration),
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        fontSize: FontManager.s08,
      ),
    );
  }
}
