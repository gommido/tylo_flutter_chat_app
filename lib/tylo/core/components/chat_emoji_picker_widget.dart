import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../resources/color_manager.dart';
import 'custom_widgets/custom_sized_box.dart';

class ChatEmojiPickerWidget extends StatelessWidget {
  const ChatEmojiPickerWidget({super.key, required this.offstage, required this.controller, this.onBackspacePressed});
  final bool offstage;
  final TextEditingController controller;
  final Function()? onBackspacePressed;


  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: offstage,
      child: CustomSizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: EmojiPicker(
            textEditingController: controller,
            onBackspacePressed: onBackspacePressed,
            config: Config(
                emojiViewConfig: EmojiViewConfig(
                  backgroundColor: ColorManager.backgroundColor,
                  columns: 7,
                  buttonMode: ButtonMode.MATERIAL,
                  emojiSizeMax: 25,
                  verticalSpacing: 0,
                  horizontalSpacing: 0,
                  gridPadding: EdgeInsets.zero,
                  recentsLimit: 28,
                  replaceEmojiOnLimitExceed: false,
                  noRecents: Text(
                    AppStrings.noRecent,
                    style:Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  loadingIndicator: const SizedBox.shrink(),
                ),
                bottomActionBarConfig: BottomActionBarConfig(
                  backgroundColor: ColorManager.grey.withOpacity(0.1),
                ),
                categoryViewConfig: CategoryViewConfig(
                  backgroundColor: ColorManager.grey.withOpacity(0.1),
                  iconColor: ColorManager.grey,
                  iconColorSelected: ColorManager.primaryColor,
                  dividerColor: ColorManager.primaryColor.withOpacity(0.1),
                  indicatorColor: ColorManager.primaryColor,
                ),
                checkPlatformCompatibility: true,
                searchViewConfig: const SearchViewConfig(
                  backgroundColor: ColorManager.grey,
                )
            ),
          )),
    );
  }
}
