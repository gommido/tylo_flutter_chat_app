import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../helper_functions/date_format.dart';
import '../resources/font_manager.dart';
import 'custom_widgets/custom_text.dart';

class MessageTimeWidget extends StatelessWidget {
  const MessageTimeWidget({super.key, required this.messageTime, required this.color});
  final Timestamp messageTime;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      data: formatChatTimesInHours(messageTime),
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        color: color,
        fontSize: FontManager.s08,
      ),
    );
  }
}
