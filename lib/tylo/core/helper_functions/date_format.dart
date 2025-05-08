import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

String formatChatTimesInDays(Timestamp messageTimestamp) {
  DateTime messageDate = messageTimestamp.toDate();  // Convert Firebase Timestamp to DateTime

  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  DateTime yesterday = today.subtract(const Duration(days: 1));
  DateTime messageDay = DateTime(messageDate.year, messageDate.month, messageDate.day);

  String formattedDate = DateFormat('MM/dd/yy').format(messageDate);

  if (messageDay == today) {
    return AppStrings.today;
  } else if (messageDay == yesterday) {
    return AppStrings.yesterday;
  } else {
    return formattedDate;
  }
}




String formatChatTimesInHours(Timestamp messageTimestamp) {
  DateTime messageDate = messageTimestamp.toDate();

  String hour = messageDate.hour > 12
      ? (messageDate.hour - 12).toString()
      : messageDate.hour == 0 ? '12' : messageDate.hour.toString();
  String minute = messageDate.minute.toString().padLeft(2, '0');
  String amPm = messageDate.hour >= 12 ? AppStrings.pm : AppStrings.am;
  String formattedTime = "$hour:$minute $amPm";

  return formattedTime;
}

DateTime parseTimeString(String timeString) {
  return DateTime.parse(timeString);
}
