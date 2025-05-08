import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/components/custom_widgets/custom_sized_box.dart';
import '../../../../core/components/custom_widgets/custom_builder.dart';
import '../../../../core/components/custom_widgets/custom_row.dart';
import '../../../../core/components/custom_widgets/custom_text.dart';
import '../../../../core/components/is_user_online_icon_widget.dart';
import '../../../../core/helper_functions/capitalize_all_words.dart';
import '../../../../core/helper_functions/detect_language.dart';

class LastMessageReceiverNameWidget extends StatelessWidget {
  const LastMessageReceiverNameWidget({super.key, required this.name, required this.userId});
  final String name;
  final String userId;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomBuilder(
      builder: (context) {
        final isLatinWord = detectWordLanguage(name.split(' ').first);
        return CustomRow(
          children: [
            CustomText(
              data: isLatinWord ? capitalizeAllWords(name) : name,
              style: Theme.of(context).textTheme.bodyMedium!,
            ),
            CustomSizedBox(width: size.width / 50,),
            IsUserOnlineIconWidget(id: userId,),
          ],
        );
      }
    );
  }
}
